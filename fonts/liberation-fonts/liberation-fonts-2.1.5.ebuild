# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="A Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://pagure.io/liberation-fonts"
SRC_URI="https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-${PV}.tar.gz"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}/60-liberation.conf" )
FONT_S="${WORKDIR}/${PN}-ttf-${PV}"
S="${FONT_S}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

pkg_postinst() {
	fc-cache -fv
}
