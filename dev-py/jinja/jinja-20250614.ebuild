# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=flit

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markupsafe
"
# lockstep-pypi-deps: end
DESCRIPTION="A full-featured template engine for Python"
HOMEPAGE="https://palletsprojects.com/p/jinja/"
SNAPSHOT=5ef70112a1ff19c05324ff889dd30405b1002044
SRC_URI="https://github.com/pallets/jinja/archive/${SNAPSHOT}.tar.gz -> jinja-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jinja-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/markupsafe-2.0[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs \
	dev-py/sphinx-issues \
	dev-py/pallets-sphinx-themes
distutils_enable_tests pytest

# XXX: handle Babel better?

src_prepare() {
	# avoid unnecessary dep on extra sphinxcontrib modules
	sed -i '/sphinxcontrib.log_cabinet/ d' docs/conf.py || die

	distutils-r1_src_prepare
}

pkg_postinst() {
	if ! has_version dev-py/Babel; then
		elog "For i18n support, please emerge dev-py/Babel."
	fi
}
