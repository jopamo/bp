# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Run a function exactly one time"
HOMEPAGE="https://github.com/isaacs/once"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-js/wrappy"
