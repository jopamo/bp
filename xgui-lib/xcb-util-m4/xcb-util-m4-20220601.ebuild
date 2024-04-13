# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=c617eee22ae5c285e79e81ec39ce96862fd3262f
SRC_URI="https://gitlab.freedesktop.org/xorg/util/xcb-util-m4/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/${PN}
	doins -r *.m4
}
