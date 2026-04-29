# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1 pypi

PYPI_PN="watchfiles"
DESCRIPTION="Simple, modern and high performance file watching and code reload in python."
HOMEPAGE="https://github.com/samuelcolvin/watchfiles"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
"
# lockstep-pypi-deps: end
