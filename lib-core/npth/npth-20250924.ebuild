# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=59987e37a587ea7c4d6485ac9069c2bd199ff9a4

inherit autotools flag-o-matic

DESCRIPTION="New GNU Portable Threads Library"
HOMEPAGE="https://github.com/gpg/npth"
SRC_URI="https://github.com/gpg/npth/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/npth-${SNAPSHOT}

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
