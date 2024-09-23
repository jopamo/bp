# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=GUIDO

inherit perl-module flag-o-matic

DESCRIPTION="High-Level Interface to Uniforum Message Translation"
HOMEPAGE="http://guido-flohr.net/projects/libintl-perl ${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
