# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module flag-o-matic

DESCRIPTION="High-Level Interface to Uniforum Message Translation"
HOMEPAGE="https://metacpan.org/release/libintl-perl"
SNAPSHOT=f6de629e6b449c5364266c5b6c40a875e783338c
SRC_URI="https://github.com/gflohr/libintl-perl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
