# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake user

DESCRIPTION="High-performance inference of large language models (llama.cpp)"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"
SNAPSHOT=c830f99cfa79d7e627e48de32280838f97b41115
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llama.cpp-${SNAPSHOT}"

LICENSE="CMake"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

src_configure() {
	addpredict "/proc/self/task"

	local mycmakeargs=(
		-D GGML_CUDA=ON
		-D CMAKE_CUDA_ARCHITECTURES="86"
		-D LLAMA_CURL=OFF
		-D LLAMA_SERVER_SSL=ON
		-D CMAKE_BUILD_TYPE=Release
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/whisper-server.service
	fi

	insinto /etc/whisper-server
	insopts -m 0644
	doins "${FILESDIR}"/whisper-server.env
}

pkg_preinst() {
	enewgroup llama 1338
	enewuser llama 1338 -1 /opt/llm-models llama,video
}
