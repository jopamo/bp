# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake python-single-r1

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF utilities"
HOMEPAGE="https://git.kernel.org/cgit/devel/pahole/pahole.git/"

SNAPSHOT=1cb4202ed2cbd591734f6b7fb1d2b8aa8eb5a1c3
SRC_URI="https://github.com/acmel/dwarves/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="lib-net/libbpf"

src_prepare() {
	[[ -d "${WORKDIR}"/${P}-patches ]] && PATCHES+=( "${WORKDIR}"/${P}-patches )

	cmake_src_prepare
	python_fix_shebang ostra/ostra-cg ostra/python/ostra.py
}

src_configure() {
	local mycmakeargs=(
		-D__LIB=lib
		-DLIBBPF_EMBEDDED=OFF
	)
	cmake_src_configure

	local mycmakeargs=( "-D__LIB=lib" )
	cmake_src_configure
}
