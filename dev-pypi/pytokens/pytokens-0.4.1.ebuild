# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="A fast Python tokenizer that backports Python 3.14 tokenization"
HOMEPAGE="https://github.com/tusharsadhwani/pytokens"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	sed -i \
		-e 's/"setuptools>=69", "wheel", "mypy"/"setuptools>=69", "wheel"/' \
		-e 's/USE_MYPYC = platform.python_implementation() == \"CPython\"/USE_MYPYC = False/' \
		pyproject.toml setup.py || die

	distutils-r1_src_prepare
}
