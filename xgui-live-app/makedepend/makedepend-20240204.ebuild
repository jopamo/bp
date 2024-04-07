# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="create dependencies in makefiles"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=4d8b529937da8d83691ad4b6d9fea7cb82801598
SRC_URI="https://gitlab.freedesktop.org/xorg/util/makedepend/-/archive/${SNAPSHOT}/makedepend-${SNAPSHOT}.tar.bz2 -> makedepend-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/makedepend-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	xgui-live-app/xorgproto"

src_prepare() {
	eautoreconf
	default
}
