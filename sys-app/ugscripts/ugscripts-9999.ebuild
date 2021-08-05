# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Misc scripts"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/ugscripts.git"
	inherit git-r3
else
	SNAPSHOT=b18d15009ba91ce2603f298290fccbe94d519ced
	SRC_URI="https://github.com/jopamo/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

src_install() {
	use video && dobin video/*
	dosbin sbin/*
}
