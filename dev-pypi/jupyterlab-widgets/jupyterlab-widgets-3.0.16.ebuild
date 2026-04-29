# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Jupyter interactive widgets for JupyterLab"
HOMEPAGE="https://github.com/jupyter-widgets/ipywidgets"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/26/2d/ef58fed122b268c69c0aa099da20bc67657cdfb2e222688d5731bd5b971d/jupyterlab_widgets-3.0.16.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jupyterlab_widgets-3.0.16"
