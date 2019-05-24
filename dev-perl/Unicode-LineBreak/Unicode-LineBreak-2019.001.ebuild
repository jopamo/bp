# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=NEZUMI

inherit perl-module flag-o-matic

DESCRIPTION="UAX #14 Unicode Line Breaking Algorithm"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs -Wl,-z,relro
