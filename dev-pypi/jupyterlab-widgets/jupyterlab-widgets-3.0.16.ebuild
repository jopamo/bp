# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="jupyterlab-widgets"
DESCRIPTION="Jupyter interactive widgets for JupyterLab"
HOMEPAGE="https://github.com/jupyter-widgets/ipywidgets"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
