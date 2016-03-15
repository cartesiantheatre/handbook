#!/usr/bin/env python
# validate_urls, to validate urls in a BibTeX database.
# Copyright (C) 2010-2016 Cartesian Theatre <info@cartesiantheatre.com>.
#
# Public discussion on IRC available at #avaneya (irc.freenode.net) or
# on the mailing list <avaneya@lists.avaneya.com>.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Requirement
# #########################################################################
# bibtexparser, fake_useragent, tqdm
# To install those requirements
#     pip install bibtexparser, fake_useragent, tqdm
# sudo are needed if they are going to be installed system wide.
#
# python3 is not supported for the time being.
#
# TODO
# #######################################################################
# 1. multi-threading get request.
# 2. all possible scenarios test by httpbin.org or HTTPretty
# 3. python3 support(due to incompatibility of gflags used by glog)
# 4. If the network is not stable the script will crash. Make it more stable,
#    so it could pick up at where it stops.


import argparse
import os

import bibtexparser
import requests
from fake_useragent import UserAgent
from tqdm import tqdm

from utils import glog as log

# Set up argument parser.
# #########################################################################
parser = argparse.ArgumentParser(
    description="""
    This script takes a bibtex file and validate the urls contained in it are
    dead or alive. All dead bibtex entries will be saved to file `dead.bib`.
    """)

# TODO(Shuai): Handle network unstable.

# Setup parameters.
parser.add_argument("DATABASE",
                    help="the path to the bibtex database")

args = parser.parse_args()

# Set up logging
# #########################################################################
LOG_FILE = "dead.log"
log.init(LOG_FILE)
# log.basicConfig(format='%(asctime)s %(message)s',
#                 level=log.INFO,
#                 datefmt='%m/%d/%Y %I:%M:%S %p')

# Read database
# #######################################################################
DATABASE_PATH = os.path.realpath(args.DATABASE)
# Read the bibtex file.
with open(DATABASE_PATH) as bib_file:
    bib_string = bib_file.read()

bib_database = bibtexparser.loads(bib_string)

# Set up request header to fake a browser.
headers = {
    "User-Agent": UserAgent().chrome
}

# For each url in the file, test whether it is accessible.
# #########################################################################
log.info("Start validating a total of {} urls in `{}`".format(
    len(bib_database.entries), DATABASE_PATH))
log.info("All dead links are saved to {}.".format(LOG_FILE))

for entry in tqdm(bib_database.entries):
    try:
        url = entry["link"]

        # Add default header if there is no header.
        if url[0:8] != "https://" and url[0:7] != "http://":
            url = "http://" + url
        # Take backslash as a forward slash
        url = url.replace('\\', '')

        # Actual connect.
        webpage = requests.get(url, timeout=10, headers=headers, verify=False)
        webpage.raise_for_status()
    except KeyError:
        pass
    except requests.exceptions.MissingSchema as e:
        log.info("Cannot handle schema `{}` of `{}`.".format(url, entry["ID"]))
    except requests.exceptions.ConnectionError as e:
        log.info("Cannot connect to `{}` of `{}: {}`.".format(url,
                                                              entry["ID"],
                                                              e.message))
    except requests.exceptions.Timeout as e:
        log.info("Timeout when connecting `{}` of `{}`.".format(url,
                                                                entry["ID"]))
    except requests.exceptions.HTTPError as e:
        log.info("HTTP error {} from `{}` of `{}`.".format(e.message,
                                                           url,
                                                           entry["ID"]))

log.info("Validation finished at URL: `{}`, entry ID: `{}`".format(
    url, entry["ID"]))
