# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://sourceware.org/libffi/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libffi/libffi.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=5e6ca054148dfb4d78e6f79457d48b745f919def
	SRC_URI="https://github.com/libffi/libffi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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
