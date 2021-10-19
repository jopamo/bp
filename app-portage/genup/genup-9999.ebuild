# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Update Portage tree and all installed packages"
HOMEPAGE="https://github.com/jopamo/${PN}"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	dosbin "${PN}"
	doman "${PN}.8"
}
