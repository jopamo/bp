# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module flag-o-matic

DESCRIPTION="High-Level Interface to Uniforum Message Translation"
HOMEPAGE="https://metacpan.org/release/libintl-perl"
SNAPSHOT=eea2c47a4124a115a119c63414932e2a4f8e5df3
SRC_URI="https://github.com/gflohr/libintl-perl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
