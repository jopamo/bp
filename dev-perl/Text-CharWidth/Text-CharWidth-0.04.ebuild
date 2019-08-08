# Distributed under the terms of the GNU General Public License v2

EAPI=6

MODULE_AUTHOR=KUBOTA

inherit perl-module flag-o-matic

DESCRIPTION="Get number of occupied columns of a string on terminal"

SLOT="0/1"
KEYWORDS="amd64 arm64"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro
