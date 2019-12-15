# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"

SNAPSHOT=aa47b4c438421595b2764044b54502ad378cd7e5
SRC_URI="https://github.com/swig/swig/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3+ BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ccache pcre"

RESTRICT="test"

DEPEND="pcre? ( lib-dev/libpcre )
		ccache? ( lib-sys/zlib )"

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
	econf \
		$(use_enable ccache) \
		$(use_with pcre)
}
