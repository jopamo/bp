# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Require global variables"
HOMEPAGE="https://github.com/Raynos/global"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	rm -rf {.github,.gitignore,README*,*.{png,gif}}  || die
}

src_install() {
	local node_modules="${ED}"/usr/lib/node_modules/${PN}
	mkdir -p "${node_modules}" || die
	cp -rp "${S}"/* "${node_modules}"/ || die
}
