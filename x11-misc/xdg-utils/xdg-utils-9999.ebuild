# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-utils/"
EGIT_REPO_URI=https://github.com/freedesktop/${PN}.git

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="doc"

RDEPEND="
	sys-app/dbus
	x11-misc/shared-mime-info
	x11-app/xprop
	x11-app/xset
"
DEPEND=">=app-text/xmlto-0.0.26-r1[text(+)]"

RESTRICT="test" # Disabled because of sandbox violation(s)

src_prepare() {
	eautoreconf
	default
}
