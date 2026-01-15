# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools meson

DESCRIPTION="package manager"
HOMEPAGE="https://github.com/jopamo/pm/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/pm"
	inherit git-r3
else
	SNAPSHOT=262684f8e4cbcee37dce79960fe167beefbe04c4
	SRC_URI="https://github.com/jopamo/pm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
