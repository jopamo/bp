# Distributed under the terms of the GNU General Public License v2

inherit cargo

DESCRIPTION="A cross-platform, OpenGL terminal emulator"
HOMEPAGE="https://github.com/alacritty/alacritty"
SNAPSHOT=f99dc71708d31d5c32d4b3fa611f9a87bf22657e
SRC_URI="https://github.com/alacritty/alacritty/archive/${SNAPSHOT}.tar.gz -> alacritty-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/alacritty-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_compile() {
		einfo "compiling in src_install"
}

src_install() {
		cargo install \
			--path alacritty \
			--root="${ED}/usr" \
			|| die "cargo install failed"

		rm -f "${ED}"/usr/.crates*
}
