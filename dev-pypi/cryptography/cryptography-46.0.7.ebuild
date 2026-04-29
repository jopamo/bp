# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="cryptography is a package which provides cryptographic recipes and primitives to Python developers."
HOMEPAGE="https://github.com/pyca/cryptography"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/47/93/ac8f3d5ff04d54bc814e961a43ae5b0b146154c89c61b47bb07557679b18/cryptography-46.0.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cryptography-46.0.7"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
