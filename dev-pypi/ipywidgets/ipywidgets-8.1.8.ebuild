# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="ipywidgets"
DESCRIPTION="Jupyter interactive widgets"
HOMEPAGE="http://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/comm
	dev-pypi/ipython
	dev-pypi/jupyterlab-widgets
	dev-pypi/traitlets
	dev-pypi/widgetsnbextension
"
# lockstep-pypi-deps: end
