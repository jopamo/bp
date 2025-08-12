# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xaw library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=12e81cd8ade629256488782a2e7ae0322d84da53
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXaw/-/archive/${SNAPSHOT}/libXaw-${SNAPSHOT}.tar.bz2 -> libXaw-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxaw-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/libXpm"

src_prepare() {
	eautoreconf
	default
}
