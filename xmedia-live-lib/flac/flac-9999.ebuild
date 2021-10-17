# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="https://xiph.org/flac/"
EGIT_REPO_URI="https://github.com/xiph/flac.git"

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ogg static-libs"

DEPEND="
	ogg? ( xmedia-live-lib/libogg )
	app-compression/xz-utils
"
BDEPEND="
	sys-devel/gettext
	dev-util/pkgconf
"

src_prepare() {
	touch config.rpath
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-doxygen-docs
		--disable-examples
		--disable-xmms-plugin
		--disable-altivec
		--enable-cpplibs
		$(use_enable debug)
		$(use_enable ogg)
		$(use_enable static-libs static)
		--with-ogg
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_test() {
	if [[ ${UID} != 0 ]]; then
		emake -j1 check
	else
		ewarn "Tests will fail if ran as root, skipping."
	fi
}
