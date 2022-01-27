# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="glob functionality for node.js"
HOMEPAGE="https://github.com/isaacs/node-glob"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/fs-realpath
	dev-js/inflight
	dev-js/inherits
	dev-js/minimatch
	dev-js/once
	dev-js/path-is-absolute
"
