# Distributed under the terms of the GNU General Public License v2

inherit perl-module flag-o-matic

DESCRIPTION="High-Level Interface to Uniforum Message Translation"
HOMEPAGE="https://metacpan.org/release/libintl-perl"
SNAPSHOT=abea71df8551d0f0829e222f695383979ca8f3ec
SRC_URI="https://github.com/gflohr/libintl-perl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
