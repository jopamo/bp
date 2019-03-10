# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="https://xiph.org/flac/"
EGIT_REPO_URI="https://github.com/xiph/flac.git"

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="altivec +cxx debug ogg static-libs"

RDEPEND="ogg? ( >=lib-media/libogg-1.3.0 )"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	!elibc_uclibc? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	default
	./autogen.sh
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-doxygen-docs
		--disable-examples
		--disable-xmms-plugin
		$(use_enable altivec)
		$(use_enable cxx cpplibs)
		$(use_enable debug)
		$(use_enable ogg)
		$(use_enable static-libs static)

		# cross-compile fix (bug #521446)
		# no effect if ogg support is disabled
		--with-ogg
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_test() {
	if [[ ${UID} != 0 ]]; then
		emake -j1 check
	else
		ewarn "Tests will fail if ran as root, skipping."
	fi
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
