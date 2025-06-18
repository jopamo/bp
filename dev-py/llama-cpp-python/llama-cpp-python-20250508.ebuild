# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core

inherit distutils-r1 toolchain-funcs

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="https://github.com/abetlen/llama-cpp-python"
SNAPSHOT=b1d23df0bbd327b774083b5cf88e67ca0dd52b92
SRC_URI="https://github.com/abetlen/llama-cpp-python/archive/${SNAPSHOT}.tar.gz -> llama-cpp-python-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/llama-cpp-python-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local mycmakeargs=(
		-DLLAMA_BUILD=OFF
	)
	cmake_src_configure
}
