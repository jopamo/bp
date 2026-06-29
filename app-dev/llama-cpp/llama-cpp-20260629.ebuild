# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy user

DESCRIPTION="High-performance inference of large language models (llama.cpp)"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"
SNAPSHOT=277a105dc8f8643dab54331926a9830860a03292
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llama.cpp-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="network-sandbox"

IUSE="cuda systemd"

BDEPEND="
	app-server/nodejs
"

DEPEND="
	cuda? ( bin/nvidia-cuda )
	virtual/ssl
	systemd? ( app-core/systemd )
"
RDEPEND="${DEPEND}"

src_configure() {
	addpredict "/proc/self/task"
	qa-policy-configure
	export NODE_ENV=development
	export npm_config_cache="${T}/npm-cache"
	export npm_config_include=dev
	export npm_config_omit=
	export npm_config_production=false
	export npm_config_update_notifier=false
	export npm_config_fund=false

	local mycmakeargs=(
		-D GGML_CUDA=$(usex cuda ON OFF)
		-D LLAMA_OPENSSL=ON
		-D LLAMA_BUILD_UI=ON
		-D LLAMA_USE_PREBUILT_UI=ON
		-D LLAMA_BUILD_TESTS=OFF
		-D LLAMA_TESTS_INSTALL=OFF
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if ! grep -Eq '^#define LLAMA_UI_HAS_ASSETS 1$' "${BUILD_DIR}"/tools/ui/ui.h; then
		eerror "llama-server built without embedded Web UI assets"
		if [[ -f ${BUILD_DIR}/tools/ui/ui.h ]]; then
			eerror "tools/ui/ui.h:"
			sed -n '1,40p' "${BUILD_DIR}"/tools/ui/ui.h >&2 || true
		fi
		if [[ -d ${BUILD_DIR}/tools/ui/dist ]]; then
			eerror "tools/ui/dist contents:"
			find "${BUILD_DIR}"/tools/ui/dist -maxdepth 3 -type f | sort >&2 || true
		fi
		if [[ -n ${PORTAGE_LOG_FILE} && -f ${PORTAGE_LOG_FILE} ]]; then
			eerror "Recent UI provisioning lines from build log:"
			grep -nE '(^-- UI:|stderr:|npm|llama-ui-embed|tools/ui/dist)' "${PORTAGE_LOG_FILE}" | tail -n 160 >&2 || true
		fi
		die "llama-server built without embedded Web UI assets"
	fi
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
