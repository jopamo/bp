# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION=" A cross-platform, OpenGL terminal emulator."
HOMEPAGE="https://github.com/alacritty/alacritty"
SNAPSHOT=5168dada106117f85f37eac6b685809b03b31b27
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
