# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Portable Unix shell commands for Node.js "
HOMEPAGE="https://github.com/shelljs/shelljs"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/brace-expansion
	dev-js/execa
	dev-js/fs-realpath
	dev-js/glob
	dev-js/inherits
	dev-js/interpret
	dev-js/minimatch
	dev-js/rechoir
"
