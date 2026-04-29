# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A beautiful reStructuredText renderer for rich"
HOMEPAGE="https://wasi-master.github.io/rich-rst"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bc/6d/a506aaa4a9eaa945ed8ab2b7347859f53593864289853c5d6d62b77246e0/rich_rst-1.3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rich_rst-1.3.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/docutils
	dev-pypi/rich
"
# lockstep-pypi-deps: end
