# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic user

DESCRIPTION="Cross platform Make"
HOMEPAGE="https://cmake.org/"
SNAPSHOT=c46503014db0d63fa7b1b28c58adfb51054e2dec
SRC_URI="https://github.com/ggml-org/llama.cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llama.cpp-${SNAPSHOT}"

LICENSE="CMake"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

src_configure() {
	filter-gcc
    filter-lto

	addpredict "/proc/self/task"

	local mycmakeargs=(
		-D GGML_CUDA=ON
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
}

pkg_preinst() {
	enewgroup llama 1338
	enewuser llama 1338 -1 /opt/llm-models llama,video
}
