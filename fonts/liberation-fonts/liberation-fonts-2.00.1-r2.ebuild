# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_7 )

inherit font python-any-r1

DESCRIPTION="A Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://pagure.io/liberation-fonts"
SRC_URI="https://releases.pagure.org/liberation-fonts/${PN}-ttf-${PV}.tar.gz"

KEYWORDS="amd64 arm64"
SLOT="0"
LICENSE="OFL-1.1"
IUSE="fontforge X"

FONT_SUFFIX="ttf"

FONT_CONF=( "${FILESDIR}/60-liberation.conf" )

DEPEND="
	fontforge? (
		${PYTHON_DEPS}
		app-media/fontforge
		dev-python/fonttools
	)"
RDEPEND=""

pkg_setup() {
	if use fontforge; then
		FONT_S="${S}/${PN}-ttf-${PV}"
		python-any-r1_pkg_setup
	else
		FONT_S="${WORKDIR}/${PN}-ttf-${PV}"
		S="${FONT_S}"
	fi
	font_pkg_setup
}
