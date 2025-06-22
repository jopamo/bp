# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="A Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://pagure.io/liberation-fonts"
SRC_URI="https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-${PV}.tar.gz"

KEYWORDS="amd64 arm64"
SLOT="0"
LICENSE="OFL-1.1"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}/60-liberation.conf" )

pkg_setup() {
	FONT_S="${WORKDIR}/${PN}-ttf-${PV}"
	S="${FONT_S}"

	font_pkg_setup
}

pkg_postinst() {
	fc-cache -fv
}
