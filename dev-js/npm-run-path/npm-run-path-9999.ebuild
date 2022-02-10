# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Get your PATH prepended with locally installed binaries"
HOMEPAGE="https://github.com/sindresorhus/npm-run-path"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-js/path-key"
