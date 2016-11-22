#!/usr/bin/env python
from __future__ import print_function
import keyring
import sys


def get_password(service, username):
    password = keyring.get_password(service, username)
    if password is None:
        import getpass
        password = getpass.getpass('Password not set yet. Set Password: ')
    keyring.set_password(service, username, password)
    return password

if __name__ == "__main__":
    print(get_password(sys.argv[1:2][0], sys.argv[2:3][0]))
