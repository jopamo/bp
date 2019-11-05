# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="exFAT filesystem FUSE module"
HOMEPAGE="https://github.com/relan/exfat"
EGIT_REPO_URI="https://github.com/relan/exfat.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="sys-fs/fuse:3"

src_prepare() {
	default
	eautoreconf
}
