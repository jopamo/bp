# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Consume Server-Sent Event (SSE) messages with HTTPX."
HOMEPAGE="https://github.com/florimondmanca/httpx-sse"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0f/4c/751061ffa58615a32c31b2d82e8482be8dd4a89154f003147acee90f2be9/httpx_sse-0.4.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httpx_sse-0.4.3"
