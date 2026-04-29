# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Jupyter interactive widgets"
HOMEPAGE="http://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/4c/ae/c5ce1edc1afe042eadb445e95b0671b03cee61895264357956e61c0d2ac0/ipywidgets-8.1.8.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ipywidgets-8.1.8"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/comm
	dev-pypi/ipython
	dev-pypi/jupyterlab-widgets
	dev-pypi/traitlets
	dev-pypi/widgetsnbextension
"
# lockstep-pypi-deps: end
