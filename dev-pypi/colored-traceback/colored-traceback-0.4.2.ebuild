# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Automatically color uncaught exception tracebacks"
HOMEPAGE="https://pypi.org/project/colored-traceback/"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/07/80/afcf567031ab8565f8f8d2bd14b007d313ea3258e50394e85b10a405099c/colored-traceback-0.4.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/colored-traceback-0.4.2"
