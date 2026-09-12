# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=d598176759f5d199e288cf78413cfaa3bf84449f

inherit autotools qa-policy

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="https://www.swig.org/"
SRC_URI="https://github.com/swig/swig/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3+ BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ccache pcre"

RESTRICT="test"

DEPEND="
	pcre? ( lib-core/libpcre2 )
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

	qa-policy-configure
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
