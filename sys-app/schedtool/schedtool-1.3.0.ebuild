# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A tool to query or alter a process' scheduling policy"
HOMEPAGE="http://freequaos.host.sk/schedtool"
SRC_URI="https://src.fedoraproject.org/repo/pkgs/schedtool/${P}.tar.bz2/0d968f05d3ad7675f1f33ef1f6d0a3fb/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i '/^CFLAGS=/d;/^install:/s/install-doc//' Makefile || die
	sed -i.bak -e "s/schedtool.8.gz/schedtool.8/g" "Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake GZIP="" DESTPREFIX="${ED}"/usr install
	cleanup_install
}
