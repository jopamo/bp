# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=KUBOTA
DIST_VERSION=0.04

inherit perl-module flag-o-matic

DESCRIPTION="Get number of occupied columns of a string on terminal"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
