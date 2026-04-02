# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core

inherit distutils-r1 cmake

DESCRIPTION="Python bindings for llama.cpp"
HOMEPAGE="https://github.com/abetlen/llama-cpp-python"
SNAPSHOT=7257ba95fbbf65201fd5bf4b7f0bdd1c701e1345
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
