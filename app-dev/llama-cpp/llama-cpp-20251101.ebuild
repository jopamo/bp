# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic user

DESCRIPTION="High-performance inference of large language models (llama.cpp)"
HOMEPAGE="https://cmake.org/"
SNAPSHOT=1ae74882f8f6755e44dff8f23f3abdc5b53ab7c1
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
		doins "${FILESDIR}"/llama-server.service
	fi

	insinto /etc/llama-server
	insopts -m 0644
	doins "${FILESDIR}"/llama-server.env

	newbin convert_hf_to_gguf.py convert_hf_to_gguf
	newbin convert_hf_to_gguf_update.py convert_hf_to_gguf_update
	newbin convert_llama_ggml_to_gguf.py convert_llama_ggml_to_gguf
	newbin convert_lora_to_gguf.py convert_lora_to_gguf
}

pkg_preinst() {
	enewgroup llama 1338
	enewuser llama 1338 -1 /opt/llm-models llama,video
}
