#!/usr/bin/python3
# vim:set et sw=4:
#
# certdata2pem.py - splits certdata.txt into multiple files
#
# Copyright (C) 2009 Philipp Kern <pkern@debian.org>
#
# Licensed under the GNU GPL v2 or later.

import base64
import os
import re
import sys
import textwrap
import io
import hashlib

objects = []

# Dirty file parser.
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

# Read blacklist.
blacklist = []
if os.path.exists('blacklist.txt'):
    for line in open('blacklist.txt', 'r'):
        line = line.strip()
        if line.startswith('#') or len(line) == 0:
            continue
        item = line.split('#', 1)[0].strip()
        blacklist.append(item)

# Build up trust database.
trust = dict()
for obj in objects:
    if obj['CKA_CLASS'] != 'CKO_NSS_TRUST':
        continue
    if obj['CKA_LABEL'] in blacklist:
        print("Certificate %s blacklisted, ignoring." % obj['CKA_LABEL'])
    elif obj['CKA_TRUST_SERVER_AUTH'] == 'CKT_NSS_TRUSTED_DELEGATOR':
        trust[obj['CKA_LABEL']] = True
    elif obj['CKA_TRUST_SERVER_AUTH'] == 'CKT_NSS_NOT_TRUSTED':
        print('!'*74)
        print("UNTRUSTED BUT NOT BLACKLISTED CERTIFICATE FOUND: %s" % obj['CKA_LABEL'])
        print('!'*74)
    else:
        print("Ignoring certificate %s.  SAUTH=%s, EPROT=%s" % \
              (obj['CKA_LABEL'], obj['CKA_TRUST_SERVER_AUTH'],
               obj['CKA_TRUST_EMAIL_PROTECTION']))

# Deduplicate: SHA256 of DER bytes as the key.
written_hashes = set()
for obj in objects:
    if obj['CKA_CLASS'] == 'CKO_CERTIFICATE':
        if obj['CKA_LABEL'] not in trust or not trust[obj['CKA_LABEL']]:
            continue

        der_bytes = obj['CKA_VALUE']
        # For Python 2/3 compatibility:
        if isinstance(der_bytes, str):
            der_bytes = der_bytes.encode('latin1')  # treat as bytes

        sha256 = hashlib.sha256(der_bytes).hexdigest()
        if sha256 in written_hashes:
            print("Skipping duplicate certificate (SHA256=%s)." % sha256)
            continue
        written_hashes.add(sha256)

        # Base name by label, fallback to hash if needed
        bname = obj['CKA_LABEL'][1:-1].replace('/', '_')\
                                      .replace(' ', '_')\
                                      .replace('(', '=')\
                                      .replace(')', '=')\
                                      .replace(',', '_')
        # For filesystem safety, also fallback to hash if label is empty or bad
        if not bname or bname.strip() == '':
            bname = sha256

        # Unicode/bytes handling
        if bytes != str:
            bname = bname.encode('utf-8').decode('unicode_escape').encode('latin-1')
            fname = bname + b'.crt'
        else:
            bname = bname.encode('utf-8').decode('string_escape')
            fname = bname + b'.crt'

        if os.path.exists(fname):
            print("Found duplicate filename %s, using hash instead." % fname)
            fname = sha256 + (b'.crt' if isinstance(fname, bytes) else '.crt')

        with open(fname, 'w') as f:
            f.write("-----BEGIN CERTIFICATE-----\n")
            encoded = base64.b64encode(der_bytes).decode('utf-8')
            f.write("\n".join(textwrap.wrap(encoded, 64)))
            f.write("\n-----END CERTIFICATE-----\n")
