# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool ltprune multilib-minimal toolchain-funcs

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="common-lisp nls static-libs"

RDEPEND="nls? ( >=sys-devel/gettext-0-r1[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)]
		!<=app-misc/emul-linux-x86-baselibs-20131008-r12
	)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/gpg-error-config
)
MULTILIB_WRAPPED_HEADERS=(
	/usr/include/gpg-error.h
	/usr/include/gpgrt.h
)

src_prepare() {
	default
	elibtoolize
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		CC_FOR_BUILD="$(tc-getBUILD_CC)" \
		--enable-threads \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable common-lisp languages) \
		$(multilib_is_native_abi || echo --disable-languages)
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --all
}
