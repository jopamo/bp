# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Simple, modern and high performance file watching and code reload in python."
HOMEPAGE="https://github.com/samuelcolvin/watchfiles"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c2/c9/8869df9b2a2d6c59d79220a4db37679e74f807c559ffe5265e08b227a210/watchfiles-1.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/watchfiles-1.1.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
"
# lockstep-pypi-deps: end
