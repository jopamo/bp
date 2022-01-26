# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="window.crypto.getRandomValues for fallback to Node.js crypto"
HOMEPAGE="https://github.com/KenanY/get-random-values"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-js/global"
