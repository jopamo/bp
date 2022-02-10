# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Add callbacks to requests in flight to avoid async duplication"
HOMEPAGE="https://github.com/npm/inflight"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-js/once
	dev-js/wrappy
"
