# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="https://xiph.org/flac/"
SNAPSHOT=59fa3402cb19b6b7c85b916f138cfb03c7b27504
SRC_URI="https://github.com/xiph/flac/archive/${SNAPSHOT}.tar.gz -> flac-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flac-${SNAPSHOT}"

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cpplibs debug ogg static-libs"

DEPEND="ogg? ( xmedia-lib/libogg )"

src_prepare() {
	qa-policy-configure
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

src_test() {
	# The suite needs both tools, but --disable-programs keeps them out of install.
	emake -C src/flac
	emake -C src/metaflac
	default
}

src_install() {
	default
	qa-policy-install
}
