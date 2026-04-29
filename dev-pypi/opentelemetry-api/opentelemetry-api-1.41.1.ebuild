# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="opentelemetry-api"
DESCRIPTION="OpenTelemetry Python API"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python/tree/main/opentelemetry-api"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/importlib-metadata
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
