# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Brace expansion, as known from sh/bash, in JavaScript"
HOMEPAGE="https://github.com/juliangruber/brace-expansion"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-js/balanced-match"
