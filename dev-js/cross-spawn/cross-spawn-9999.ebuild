# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="A cross platform solution to node's spawn and spawnSync"
HOMEPAGE="https://github.com/moxystudio/node-cross-spawn"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/path-key
	dev-js/shebang-command
	dev-js/which
"
