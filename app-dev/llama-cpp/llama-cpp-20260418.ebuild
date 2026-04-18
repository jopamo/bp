# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy user

DESCRIPTION="High-performance inference of large language models (llama.cpp)"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"
SNAPSHOT=fd1c0ec3f037f47f8ed76d99d0fd3cacdcc0baab
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llama.cpp-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cuda systemd"

DEPEND="
	cuda? ( bin/nvidia-cuda )
	lib-net/openssl
	systemd? ( app-core/systemd )
"
RDEPEND="${DEPEND}"

src_configure() {
	addpredict "/proc/self/task"
	qa-policy-configure

	local mycmakeargs=(
		-D GGML_CUDA=$(usex cuda ON OFF)
		-D LLAMA_OPENSSL=ON
		-D LLAMA_BUILD_TESTS=OFF
		-D LLAMA_TESTS_INSTALL=OFF
	)
	if use cuda; then
		mycmakeargs+=( -D CMAKE_CUDA_ARCHITECTURES="86" )
	fi

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

	qa-policy-install
}

pkg_preinst() {
	enewgroup llama 1338
	enewuser llama 1338 -1 /opt/llm-models llama,video
}
