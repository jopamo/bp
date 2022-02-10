# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Implements the node.js require.resolve() algorithm"
HOMEPAGE="https://github.com/browserify/resolve"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/is-core-module
	dev-js/path-parse
"
