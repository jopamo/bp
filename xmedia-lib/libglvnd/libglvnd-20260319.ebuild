# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://gitlab.freedesktop.org/glvnd/libglvnd"

SNAPSHOT=c046a760d845416e98ac4128757b2b356c47fdaa
SRC_URI="https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/${SNAPSHOT}/libglvnd-${SNAPSHOT}.tar.bz2 -> libglvnd-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libglvnd-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXext
"
DEPEND="
	${RDEPEND}
	xgui-tools/xorgproto
"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dgles1=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
