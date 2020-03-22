# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/file/file.git"
	inherit git-r3
else
	SNAPSHOT=cdf8d4bc387994ce1064d263689de98c022be7d3
	SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi


LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs zlib"

DEPEND="
	lib-sys/libseccomp
	zlib? ( >=lib-sys/zlib-1.2.8-r1 )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-libseccomp
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
