# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy xdg

DESCRIPTION="Capture and annotate screenshots on X11"
HOMEPAGE="https://gitlab.com/pjo/stillmark"
SNAPSHOT=6102758e373259b628059a02aca6f429351810e3
SRC_URI="https://gitlab.com/pjo/stillmark/-/archive/${SNAPSHOT}/stillmark-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/stillmark-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:6
	xgui-lib/qtsvg:6
"

src_configure() {
	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
