# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross platform Make"
HOMEPAGE="https://cmake.org/"

SNAPSHOT=3cb203c89f60483e349f841684173446ed23c28f
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llama.cpp-${SNAPSHOT}"

LICENSE="CMake"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE=""

src_configure() {
	addpredict "/proc/self/task"

	local mycmakeargs=(
		-D GGML_CUDA=ON
	)

	cmake_src_configure
}
