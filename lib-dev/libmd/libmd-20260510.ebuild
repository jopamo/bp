# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Provides message digest functions found on BSD systems"
HOMEPAGE="https://www.hadrons.org/software/libmd/"

SNAPSHOT=90c4f432134c608c7e2b4dd0a1d7ca5c40b92c7a
SRC_URI="https://github.com/guillemj/libmd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
}
