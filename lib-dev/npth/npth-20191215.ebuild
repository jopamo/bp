# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=09a12a679ec0bb3d8a46757c8df65166949eb223

inherit autotools

DESCRIPTION="New GNU Portable Threads Library"
HOMEPAGE="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=npth.git"
SRC_URI="https://github.com/gpg/npth/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
