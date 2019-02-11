# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="The Ogg Vorbis sound file format library"
HOMEPAGE="https://xiph.org/vorbis/"
SRC_URI="https://downloads.xiph.org/releases/vorbis/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-media/libogg-1.3.0[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-misc/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig"


src_prepare() {
	sed -i \
		-e '/CFLAGS/s:-O20::' \
		-e '/CFLAGS/s:-mcpu=750::' \
		-e '/CFLAGS/s:-mno-ieee-fp::' \
		configure.ac || die

	# Un-hack docdir redefinition.
	find -name 'Makefile.am' \
		-exec sed -i \
			-e 's:$(datadir)/doc/$(PACKAGE)-$(VERSION):@docdir@/html:' \
			{} + || die

	AT_M4DIR="m4" \
	default
}
