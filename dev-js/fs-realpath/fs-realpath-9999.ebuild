# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Fall back to the JS implementation if the native one fails"
HOMEPAGE="https://github.com/isaacs/fs.realpath"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	local node_modules="${ED}"/usr/lib/node_modules/fs.realpath
	mkdir -p "${node_modules}" || die
	cp -rp "${S}"/* "${node_modules}"/ || die
}
