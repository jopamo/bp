# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=7e45b50a4034735bad8ba99a003bbf986c664d8c

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
