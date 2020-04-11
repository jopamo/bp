# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=JSTOWE

inherit perl-module flag-o-matic

DESCRIPTION="Change terminal modes, and perform non-blocking reads"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro
