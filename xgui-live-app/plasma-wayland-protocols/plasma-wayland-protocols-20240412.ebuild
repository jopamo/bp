# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/KDE/kwindowsystem"
	inherit git-r3
else
	SNAPSHOT=72e0e42fe8dea55b9303f4943836794a62190e48
	SRC_URI="https://github.com/KDE/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"
