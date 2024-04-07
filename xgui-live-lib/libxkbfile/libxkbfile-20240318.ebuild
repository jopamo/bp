# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org xkbfile library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=948cbfb38a76df395e7d9458c472901bcfefb969
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/${SNAPSHOT}/libxkbfile-${SNAPSHOT}.tar.bz2 -> libxkbfile-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxkbfile-${SNAPSHOT}"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile"
	inherit
	KEYWORDS="amd64 arm64"
else
	SRC_URI=""
	S="${WORKDIR}/xorg-${PN}-${P}"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-live-lib/libX11
	xgui-live-app/xorgproto
"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
