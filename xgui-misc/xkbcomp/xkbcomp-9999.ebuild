# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"
	inherit git-r3 autotools
else
	SRC_URI="https://www.x.org/archive/individual/app/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	xgui-live-lib/libX11
	xgui-live-lib/libxkbfile
"
BDEPEND="app-build/bison"

src_prepare() {
	default

	if [[ ${PV} == *9999 ]] ; then
		eautoreconf
	fi
}
