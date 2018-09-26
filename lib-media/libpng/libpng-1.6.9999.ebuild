# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 libtool ltprune multilib-minimal

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
EGIT_REPO_URI="https://github.com/glennrp/libpng.git"
EGIT_BRANCH=libpng16

LICENSE="libpng"
SLOT="0/16"
KEYWORDS="amd64 arm64 x86"
IUSE="apng cpu_flags_x86_sse neon static-libs"

RDEPEND=">=lib-sys/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-misc/emul-linux-x86-baselibs-20130224-r1
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	app-compression/xz-utils"

src_prepare() {
	eautoreconf
	default
	if use apng; then
		eapply -p0 "${WORKDIR}"/${PN}-*-apng.patch
		# Don't execute symbols check with apng patch wrt #378111
		sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die
	fi
	elibtoolize
}

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable cpu_flags_x86_sse intel-sse)
		$(use_enable static-libs static)
		--enable-arm-neon=$(usex neon)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	DOCS=( ANNOUNCE CHANGES libpng-manual.txt README TODO )
	einstalldocs
	prune_libtool_files --all
}
