# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Misc BASH scripts that get the job done, but could be dramatically improved."
HOMEPAGE="https://github.com/1g4-linux/uglyscripts.git"
EGIT_REPO_URI="https://github.com/1g4-linux/uglyscripts.git"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	dosbin *
}
