# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="OpenTelemetry Python API"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python/tree/main/opentelemetry-api"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fa/fc/b7564cbef36601aef0d6c9bc01f7badb64be8e862c2e1c3c5c3b43b53e4f/opentelemetry_api-1.41.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/opentelemetry_api-1.41.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/importlib-metadata
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
