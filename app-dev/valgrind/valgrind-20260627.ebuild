# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
SNAPSHOT=f880c686673a10b5672b4f6516a89d8afb0ac3da
SRC_URI="https://github.com/1g4-mirror/valgrind/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_CONFIG_IMPL_DECL_SKIP=(
	aio_readv
)

src_prepare() {
	filter-flags -fomit-frame-pointer -fstack-protector*
	filter-flags -flto* -Wl,-z,defs -O
	replace-flags -Os -O2
	append-flags -no-pie

	sed -i -e "s:doc/valgrind:doc/${PF}:" docs/Makefile.am || die
	sed -i -e 's:-arch \(i386\|x86_64\)::g' Makefile.all.am || die

	eapply "${FILESDIR}"/${PN}-20260416-use-compiler-rtlib-path.patch
	eapply "${FILESDIR}"/${PN}-3.7.0-respect-flags.patch

	eapply_user
	eautoreconf
}

src_configure() {
	econf --enable-only64bit
}
