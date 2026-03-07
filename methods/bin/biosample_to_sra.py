#!/usr/bin/env python3
"""
Copyright 2023 Ryan Wick (rrwick@gmail.com)
Copyright 2018 Jane Hawkey (jane.hawkey@unimelb.edu.au)

This program takes in a space-delimited list of BioSample accessions and it prints a table
of the accessions with their corresponding SRA run accessions.

I made it by modifying (mostly culling) code from this tool:
https://github.com/jhawkey/sra_read_downloader

This file is part of SRA Read Downloader. SRA Read Downloader is free software: you can
redistribute it and/or modify it under the terms of the GNU General Public License as published
by the Free Software Foundation, either version 3 of the License, or (at your option) any later
version. SRA Read Downloader is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details. You should have received a copy of
the GNU General Public License along with SRA Read Downloader. If not, see
<http://www.gnu.org/licenses/>.
"""

import argparse
import logging
import sys
import urllib.request
import xml.etree.ElementTree as Et


def main():
    biosample_accs = sys.argv[1:]
    biosample_uids = uids_from_accession(biosample_accs, 'biosample')
    biosamples = biosamples_from_biosample_uids(biosample_uids)
    for biosample_acc in biosample_accs:
        biosample = [b for b in biosamples if b.accession == biosample_acc][0]
        sra_runs = biosample.get_sra_runs()
        sra_accessions = ','.join([run.accession for run in sra_runs])
        print(f'{biosample.accession}\t{sra_accessions}')


class BadAccession(Exception):
    pass


def uids_from_accession(accessions, database):
    """
    Takes a list of accessions for any NCBI database, returns uids in no particular order.
    """
    if not isinstance(accessions, list):
        accessions = [accessions]
    # Format URL
    esearch_template_url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/' \
                           'esearch.fcgi?db=%s&term=%s&retmax=100000'
    esearch_url = esearch_template_url % (database, '+OR+'.join(accessions))

    # Make GET request
    with urllib.request.urlopen(esearch_url) as esearch_response:
        esearch_xml = esearch_response.read()
        esearch_root = Et.fromstring(esearch_xml)
        uids = [x.text for x in esearch_root.findall('./IdList/Id')]
        if len(accessions) != len(uids):
            raise BadAccession
        return uids


def biosamples_from_biosample_uids(biosample_uids):
    # First we build the BioSamples.
    biosamples = []
    efetch_url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi' + \
                 '?dbfrom=biosample&db=biosample&id=' + ','.join(biosample_uids)

    # TO DO: Using '&retmode=json' would give me JSON results, which would be a lot nicer to parse!

    with urllib.request.urlopen(efetch_url) as efetch_response:
        efetch_xml = efetch_response.read()
        efetch_root = Et.fromstring(efetch_xml)
        for biosample_xml in efetch_root.findall('./BioSample'):
            biosamples.append(BioSample(biosample_xml))

    # Then we build the SRA experiments that are linked to those biosamples.
    elink_url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi' + \
                '?dbfrom=biosample&db=sra&id=' + ','.join(b.uid for b in biosamples)
    with urllib.request.urlopen(elink_url) as elink_response:
        elink_xml = elink_response.read()
        elink_root = Et.fromstring(elink_xml)
        sra_experiment_uids = [x.text for x in elink_root.findall('./LinkSet/LinkSetDb/Link/Id')]
        sra_experiments = sra_experiments_from_sra_experiment_uids(sra_experiment_uids)

    # Now we have to associate SRA experiments with BioSamples.
    biosample_dict = {b.accession: b for b in biosamples}
    for experiment in sra_experiments:
        biosample = biosample_dict[experiment.biosample_accession]
        platform = experiment.platform.lower()
        if 'illumina' in platform:
            biosample.illumina_experiments.append(experiment)
        elif 'nanopore' in platform:
            biosample.long_read_experiments.append(experiment)
        elif 'pacbio' in platform:
            biosample.long_read_experiments.append(experiment)
        else:
            biosample.other_experiments.append(experiment)

    # Make sure all of the runs nested under this sample have the SRA sample ID.
    for biosample in biosamples:
        biosample.add_sra_sample_to_runs()

    return biosamples


def sra_experiments_from_sra_experiment_uids(sra_experiment_uids):
    efetch_url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi' + \
                    '?dbfrom=sra&db=sra&id=' + ','.join(sra_experiment_uids)
    sra_experiments = []
    with urllib.request.urlopen(efetch_url) as efetch_response:
        efetch_xml = efetch_response.read()
        efetch_root = Et.fromstring(efetch_xml)
        for sra_experiment_xml in efetch_root.findall('./EXPERIMENT_PACKAGE'):
            sra_experiments.append(SraExperiment(sra_experiment_xml))
    return sra_experiments


class BioSample(object):
    def __init__(self, biosample_xml):

        self.uid = biosample_xml.attrib.get('id')
        self.accession = biosample_xml.attrib.get('accession')
        self.sra_sample_accession = None
        for id_node in biosample_xml.iter('Id'):
            if id_node.attrib.get('db') == 'SRA':
                self.sra_sample_accession = id_node.text
        description = biosample_xml.find('Description')
        organism = description.find('Organism').attrib
        self.taxonomy_name = organism.get('taxonomy_name')
        self.illumina_experiments = []
        self.long_read_experiments = []
        self.other_experiments = []

    def __repr__(self):
        biosample_repr = str(self.accession) + ' (' + self.taxonomy_name
        if self.illumina_experiments and self.long_read_experiments:
            biosample_repr += ', hybrid'
        elif self.illumina_experiments:
            biosample_repr += ', Illumina'
        elif self.long_read_experiments:
            biosample_repr += ', long read'
        else:
            biosample_repr += ', unknown'
        biosample_repr += ')'
        return biosample_repr

    def add_sra_sample_to_runs(self):
        experiments = self.illumina_experiments + self.long_read_experiments + \
                      self.other_experiments
        runs = []
        for experiment in experiments:
            runs += experiment.runs

        for run in runs:
            run.sample = self

    def get_sra_runs(self, sra_accs=None):
        """
        This function returns the SRA run accessions for this BioSample. It will include both
        Illumina and long read SRA runs. If there are multiple runs in a category (e.g. more than
        one Illumina run), it only returns the most recent.

        It returns a list of SraRun objects
        """
        runs = []

        illumina_runs, long_read_runs, other_runs = [], [], []
        for experiment in self.illumina_experiments:
            illumina_runs += experiment.runs
        for experiment in self.long_read_experiments:
            long_read_runs += experiment.runs
        for experiment in self.other_experiments:
            other_runs += experiment.runs

        illumina_runs = sorted(illumina_runs, key=lambda x: x.published_date, reverse=True)
        long_read_runs = sorted(long_read_runs, key=lambda x: x.published_date, reverse=True)

        # If the user asked for SRA accessions explicitly, then give the exact ones they asked for.
        if sra_accs is not None:
            all_runs = illumina_runs + long_read_runs + other_runs
            return [r for r in all_runs if r.accession in sra_accs]

        runs += illumina_runs
        runs += long_read_runs
        runs += other_runs
        return runs


class SraExperiment(object):
    def __init__(self, sra_experiment_xml):
        experiment = sra_experiment_xml.find('EXPERIMENT')
        self.accession = experiment.attrib.get('accession')
        design = experiment.find('DESIGN')
        self.biosample_accession = None
        sample = sra_experiment_xml.find('SAMPLE')
        if sample is not None:
            for external_id in sample.iter('EXTERNAL_ID'):
                if external_id.attrib.get('namespace') == 'BioSample':
                    self.biosample_accession = external_id.text
        if self.biosample_accession is None:
            for external_id in design.iter('EXTERNAL_ID'):
                if external_id.attrib.get('namespace') == 'BioSample':
                    self.biosample_accession = external_id.text
        platform_node = experiment.find('PLATFORM')[0]
        self.platform = platform_node.tag
        self.runs = []
        for run_xml in sra_experiment_xml.findall('RUN_SET/RUN'):
            run = SraRun(run_xml)
            self.runs.append(run)
            run.experiment = self

    def __repr__(self):
        return str(self.accession)


class SraRun(object):

    def __init__(self, sra_run_xml):
        self.accession = sra_run_xml.attrib.get('accession')
        self.sample = None
        self.experiment = None
        self.published_date = sra_run_xml.attrib.get('published')

    def __repr__(self):
        return self.sample.sra_sample_accession + '_' + \
               self.accession + '_' + self.experiment.platform


if __name__ == '__main__':
    main()
