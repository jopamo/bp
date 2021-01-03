# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Misc BASH scripts that get the job done."
EGIT_REPO_URI="https://gitlab.com/pjo/uglyscripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

src_install() {
	use video && dobin video/*
	dosbin sbin/*
}
