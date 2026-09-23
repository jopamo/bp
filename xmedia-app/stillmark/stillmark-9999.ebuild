# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy xdg git-r3

DESCRIPTION="Capture and annotate screenshots on X11"
HOMEPAGE="https://gitlab.com/pjo/stillmark"
EGIT_REPO_URI="https://gitlab.com/pjo/stillmark.git"

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
