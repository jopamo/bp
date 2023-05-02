# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://github.com/libffi/libffi"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SNAPSHOT=ac598b7f5272d536b75f4b3833a4610cf4cd9404
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
