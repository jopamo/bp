# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT="$(ver_cut 1)-$(ver_cut 3-)"

inherit toolchain

KEYWORDS="~amd64 ~arm64"

src_prepare() {
	toolchain_src_prepare
}
