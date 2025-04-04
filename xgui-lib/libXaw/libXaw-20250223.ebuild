# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xaw library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=942b868e73e86287995ba8eefb6348ac4fb57954
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxaw-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/libXpm"

src_prepare() {
	eautoreconf
	default
}
