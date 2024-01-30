# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=a3042b9a8e4594b10df94448251c2bc5c5b6c22a
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}/build/meson
fi

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
