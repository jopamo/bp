# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Async Key-Value Store - A pluggable interface for KV Stores"
HOMEPAGE="https://pypi.org/project/py-key-value-aio/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/04/3c/0397c072a38d4bc580994b42e0c90c5f44f679303489e4376289534735e5/py_key_value_aio-0.4.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/py_key_value_aio-0.4.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/beartype
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
