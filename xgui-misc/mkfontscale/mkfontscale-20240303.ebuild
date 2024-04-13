# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="create an index of scalable font files for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=bcfa27aeef3a9eb720e6b48e3fb8a4c2813fef52
SRC_URI="https://gitlab.freedesktop.org/xorg/app/mkfontscale/-/archive/${SNAPSHOT}/mkfontscale-${SNAPSHOT}.tar.bz2 -> mkfontscale-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/mkfontscale-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-compression/bzip2
	app-compression/pigz
	lib-core/zlib
	xgui-tools/util-macros
	xgui-tools/xorgproto
	xgui-lib/libfontenc
	xgui-misc/freetype
"

src_prepare() {
	default
	eautoreconf
}
