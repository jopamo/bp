# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module flag-o-matic

DESCRIPTION="High-Level Interface to Uniforum Message Translation"
HOMEPAGE="https://metacpan.org/release/libintl-perl"
SNAPSHOT=0baa08ae33998d02c1c69aa03d8e3bab0d9d4691
SRC_URI="https://github.com/gflohr/libintl-perl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
