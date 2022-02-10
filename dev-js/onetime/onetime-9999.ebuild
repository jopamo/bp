# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 node-module

DESCRIPTION="Ensure a function is only called once"
HOMEPAGE="https://github.com/sindresorhus/onetime"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-js/mimic-fn"
