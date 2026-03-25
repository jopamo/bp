# Distributed under the terms of the GNU General Public License v2

inherit cargo

DESCRIPTION="A cross-platform, OpenGL terminal emulator"
HOMEPAGE="https://github.com/alacritty/alacritty"
SNAPSHOT=a0be6eb8240c30e4adf384dde29090406a0ae685
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
