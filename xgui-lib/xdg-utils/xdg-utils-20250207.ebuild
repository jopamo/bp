# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-utils/"

SNAPSHOT=503356e79c7357344fe58fe5183dafef93e646dc
SRC_URI="https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/${SNAPSHOT}/xdg-utils-${SNAPSHOT}.tar.bz2 -> xdg-utils-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xdg-utils-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/dbus
	xgui-misc/shared-mime-info
	xgui-tools/xprop
	xgui-tools/xset
"
DEPEND=">=app-tex/xmlto-0.0.26-r1[text(+)]"

RESTRICT="test" # Disabled because of sandbox violation(s)

src_prepare() {
	eautoreconf
	default
}
