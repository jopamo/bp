# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://gitlab.freedesktop.org/glvnd/libglvnd"

SNAPSHOT=8731041dbd78566bffafb5145aec8b8df8b5260e
SRC_URI="https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/${SNAPSHOT}/libglvnd-${SNAPSHOT}.tar.bz2 -> libglvnd-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libglvnd-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXext
"
DEPEND="
	${RDEPEND}
	xgui-tools/xorgproto
"
BDEPEND="test? ( xgui-tools/xvfb-run )"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dgles1=false
	)
	meson_src_configure
}

src_test() {
	xvfb-run -a meson test -C "${BUILD_DIR}" \
		--print-errorlogs --num-processes "$(makeopts_jobs "${MAKEOPTS}")" \
		|| die "libglvnd tests failed"
}

src_install() {
	meson_src_install
	qa-policy-install
}
