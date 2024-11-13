# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="https://xiph.org/flac/"

SNAPSHOT=5152c6cace63ee11d422c1ef9589a9a0a5d034b2
SRC_URI="https://github.com/xiph/flac/archive/${SNAPSHOT}.tar.gz -> flac-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flac-${SNAPSHOT}"

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cpplibs debug ogg static-libs"

DEPEND="ogg? ( xmedia-lib/libogg )"

src_prepare() {
	touch config.rpath
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable cpplibs)
		$(use_enable debug)
		$(use_enable ogg)
		$(use_enable static-libs static)
		--disable-doxygen-docs
		--disable-examples
		--disable-programs
		--disable-rpath
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}