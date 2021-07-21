# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=KUBOTA

inherit perl-module flag-o-matic

DESCRIPTION="Get number of occupied columns of a string on terminal"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
