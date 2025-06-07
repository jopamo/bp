# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="EDID and DisplayID library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/emersion/libdisplay-info"
	inherit git-r3
else
	SNAPSHOT=
	S=${WORKDIR}/libdisplay-info-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
