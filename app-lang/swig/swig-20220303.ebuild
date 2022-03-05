# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=8cd2cfa9d1dcbdda0fdf29029b001a90c30b1a58

inherit autotools

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="https://github.com/swig/swig/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3+ BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ccache pcre"

RESTRICT="test"

DEPEND="
	pcre? ( lib-core/libpcre )
	ccache? ( lib-core/zlib )
"

src_prepare() {
	test -d Tools/config || mkdir Tools/config
	eaclocal -I Tools/config
	eautoheader
	eautomake --add-missing --copy --force-missing
	eautoconf
	cd CCache && eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable ccache)
		$(use_with pcre)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
