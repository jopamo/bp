# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Process execution for humans"
HOMEPAGE="https://github.com/sindresorhus/execa"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/cross-spawn
	dev-js/get-stream
	dev-js/human-signals
	dev-js/is-stream
	dev-js/merge-stream
	dev-js/npm-run-path
	dev-js/onetime
	dev-js/signal-exit
	dev-js/strip-final-newline
"
