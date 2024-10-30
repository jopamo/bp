#!/usr/bin/python3
# vim:set et sw=4:
#
# certdata2pem.py - splits certdata.txt into multiple files
#
# Copyright (C) 2009 Philipp Kern <pkern@debian.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#

import base64
import os
import re
import io
import textwrap

objects = []

# Parse certdata.txt to extract objects
in_data, in_multiline, in_obj = False, False, False
field, type, value, obj = None, None, None, dict()

for line in io.open('certdata.txt', 'rt', encoding='utf8'):
    if not in_data:
        if line.startswith('BEGINDATA'):
            in_data = True
        continue
    if line.startswith('#'):
        continue
    if in_obj and len(line.strip()) == 0:
        objects.append(obj)
        obj = dict()
        in_obj = False
        continue
    if len(line.strip()) == 0:
        continue
    if in_multiline:
        if not line.startswith('END'):
            if type == 'MULTILINE_OCTAL':
                line = line.strip()
                for i in re.finditer(r'\\([0-3][0-7][0-7])', line):
                    value.append(int(i.group(1), 8))
            else:
                value += line
            continue
        obj[field] = value
        in_multiline = False
        continue
    if line.startswith('CKA_CLASS'):
        in_obj = True
    line_parts = line.strip().split(' ', 2)
    if len(line_parts) > 2:
        field, type = line_parts[0:2]
        value = ' '.join(line_parts[2:])
    elif len(line_parts) == 2:
        field, type = line_parts
        value = None
    else:
        raise NotImplementedError('line_parts < 2 not supported.')
    if type == 'MULTILINE_OCTAL':
        in_multiline = True
        value = bytearray()
        continue
    obj[field] = value
if len(obj) > 0:
    objects.append(obj)

# Read blacklist
blacklist = []
if os.path.exists('blacklist.txt'):
    with open('blacklist.txt', 'r') as f:
        for line in f:
            line = line.strip()
            if not line.startswith('#') and len(line) > 0:
                blacklist.append(line.split('#', 1)[0].strip())

# Build up trust database
trust = dict()
for obj in objects:
    if obj.get('CKA_CLASS') != 'CKO_NSS_TRUST':
        continue
    if obj['CKA_LABEL'] in blacklist:
        print(f"Certificate {obj['CKA_LABEL']} blacklisted, ignoring.")
    elif obj.get('CKA_TRUST_SERVER_AUTH') == 'CKT_NSS_TRUSTED_DELEGATOR':
        trust[obj['CKA_LABEL']] = True
    else:
        print(f"Ignoring certificate {obj['CKA_LABEL']} with trust settings.")

# Process trusted certificates
for obj in objects:
    if obj.get('CKA_CLASS') == 'CKO_CERTIFICATE' and trust.get(obj['CKA_LABEL']):
        label = obj['CKA_LABEL'][1:-1].replace('/', '_').replace(' ', '_').replace('(', '=').replace(')', '=').replace(',', '_')
        fname = f"{label}.crt"
        if os.path.exists(fname):
            print(f"Duplicate certificate name {label}, renaming.")
            fname = f"{label}_2.crt"

        with open(fname, 'w') as f:
            f.write("-----BEGIN CERTIFICATE-----\n")
            encoded = base64.b64encode(obj['CKA_VALUE']).decode('utf-8')
            f.write("\n".join(textwrap.wrap(encoded, 64)))
            f.write("\n-----END CERTIFICATE-----\n")
