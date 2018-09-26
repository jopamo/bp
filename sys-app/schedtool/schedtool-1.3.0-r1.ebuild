# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A tool to query or alter a process' scheduling policy"
HOMEPAGE="http://freequaos.host.sk/schedtool"
SRC_URI="https://src.fedoraproject.org/repo/pkgs/schedtool/schedtool-1.3.0.tar.bz2/0d968f05d3ad7675f1f33ef1f6d0a3fb/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64 x86"

src_prepare() {
	sed -i '/^CFLAGS=/d;/^install:/s/install-doc//' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTPREFIX="${ED}"/usr install
	dodoc CHANGES INSTALL PACKAGERS README SCHED_DESIGN TODO TUNING
}
