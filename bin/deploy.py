#!/usr/bin/env python3
"""
deploy my dotfiles

this script should basically copy the whole directory structure from ~/.dotfiles
to ~/ . Directories from the source are created at the target, files (and links)
are linked, if a destination file/link already exists, it is left alone.
"""

# TODO the linking everything from ~/.dotfiles/local/

import logging
import os
import sys

HOME = os.path.expanduser('~')
BASEPATH = os.path.join(HOME, '.dotfiles')

IGNORE = ['.git', 'local', 'README.md', 'UPDATE.md']


def search(relpath):
    logging.info('new path: {}'.format(relpath))
    for filename in os.listdir(os.path.join(BASEPATH, relpath)):
        filepath = os.path.join(relpath, filename)
        absfilepath = os.path.join(BASEPATH, filepath)
        destination = os.path.join(HOME, filepath)
        logging.info('  filename: {} ({})'.format(filename, filepath))

        if filepath in IGNORE:
            logging.info('    ignoring {}'.format(filepath))
            continue
        if os.path.isdir(absfilepath):
            try:
                os.makedirs(destination)
                logging.info('created directory {}'.format(destination))
            except OSError as error:
                if error.errno != 17:
                    raise
                if not os.path.isdir(destination):
                    logging.warn('something exists at {}'.format(error))
            search(filepath + '/')
            continue
        if os.path.isfile(absfilepath) or os.path.islink(absfilepath):
            try:
                os.symlink(absfilepath, destination)
                logging.info('    linked {} to {}'.format(absfilepath, destination))
            except OSError as error:
                if error.errno != 17:
                    raise
                if os.path.isfile(destination) and not os.path.islink(destination):
                    logging.warn('linking destination exists {} and is a file'.format(error))
                if os.path.isdir(destination):
                    logging.warn('linking destination exists {} and is a dir'.format(error))
            continue
        logging.fatal('PANIC!!! {}'.format(absfilepath))
        sys.exit(1)

search('')
