# Distributed under the terms of the GNU General Public License v2

EAPI=6

SNAPSHOT="8-20180921"

inherit toolchain

KEYWORDS="amd64 arm64"

src_prepare() {
	toolchain_src_prepare
}
