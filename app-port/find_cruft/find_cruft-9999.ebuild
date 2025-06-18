# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="find cruft files not managed by portage"
HOMEPAGE="https://github.com/jopamo/find_cruft"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/find_cruft"
	inherit git-r3
else
	SNAPSHOT=f5ea740f2beaff514450faac98195a6a99508adf
	SRC_URI="https://github.com/jopamo/find_cruft/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-lang/perl"

src_install() {
	dobin bin/find_cruft
}
