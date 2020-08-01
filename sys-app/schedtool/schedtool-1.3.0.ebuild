# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool to query or alter a process' scheduling policy"
HOMEPAGE="https://github.com/freequaos/schedtool"
SRC_URI="https://github.com/freequaos/schedtool/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i -e '/schedtool.8/d' Makefile || die
}

src_install() {
	dobin schedtool
}
