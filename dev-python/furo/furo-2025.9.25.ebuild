# Distributed under the terms of the GNU General Public License v2

EAPI=8

# sphinx-theme-builder is completely unusable, as it requires pinning
# to a very-specific nodejs version number, and ofc loves fetching
# everything from the Internet

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Clean customisable Sphinx documentation theme"
HOMEPAGE="
	https://pypi.org/project/furo/
	https://github.com/pradyunsg/furo/
"
SRC_URI="$(pypi_wheel_url)"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-basic-ng[${PYTHON_USEDEP}]
"

src_unpack() {
	if [[ ${PKGBUMPING} == ${PVR} ]]; then
		unzip "${DISTDIR}/${A}" || die
	fi
}

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${P}-py3-none-any.whl"
}
