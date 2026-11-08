# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"
SNAPSHOT=53180cf9e3fb28f279f3be067c49fc5d1764257c
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/archive/${SNAPSHOT}/xkbcomp-${SNAPSHOT}.tar.bz2 -> xkbcomp-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xkbcomp-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libxkbfile
"
DEPEND="${RDEPEND}"
BDEPEND="app-build/bison"

src_prepare() {
	default
  eautoreconf
}
