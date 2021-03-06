# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-utils/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/xdg-utils.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/dbus
	xgui-live-app/shared-mime-info
	xgui-live-app/xprop
	xgui-live-app/xset
"
DEPEND=">=app-tex/xmlto-0.0.26-r1[text(+)]"

RESTRICT="test" # Disabled because of sandbox violation(s)

src_prepare() {
	eautoreconf
	default
}
