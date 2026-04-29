# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Pickler class to extend the standard pickle.Pickler functionality"
HOMEPAGE="https://github.com/cloudpipe/cloudpickle"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/27/fb/576f067976d320f5f0114a8d9fa1215425441bb35627b1993e5afd8111e5/cloudpickle-3.1.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cloudpickle-3.1.2"
