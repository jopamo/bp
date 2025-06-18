# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-utils/"

SNAPSHOT=5f7169ec0ff1b15e645c10566678b6cc062795dc
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
BDEPEND="
	app-tex/xmlto
	app-net/lynx
"

RESTRICT="test"

src_prepare() {
	eautoreconf
	default

sed -Ei '
  s#(http://www\.oasis-open\.org/docbook/xml/)4\.(1\.2|3)(/docbookx\.dtd)#\14.5\3#g;
  s#-//OASIS//DTD DocBook XML V4\.(1\.2|3)//EN#-//OASIS//DTD DocBook XML V4.5//EN#g
' \
scripts/desc/xdg-copy.xml \
scripts/desc/xdg-desktop-icon.xml \
scripts/desc/xdg-desktop-menu.xml \
scripts/desc/xdg-email.xml \
scripts/desc/xdg-file-dialog.xml \
scripts/desc/xdg-icon-resource.xml \
scripts/desc/xdg-mime.xml \
scripts/desc/xdg-open.xml \
scripts/desc/xdg-realpath.xml \
scripts/desc/xdg-screensaver.xml \
scripts/desc/xdg-settings.xml \
scripts/desc/xdg-su.xml \
scripts/desc/xdg-terminal.xml \
scripts/desc/xdg-utils-common.xml || die

}
