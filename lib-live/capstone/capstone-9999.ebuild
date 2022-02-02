# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
EGIT_REPO_URI="https://github.com/capstone-engine/capstone"
EGIT_BRANCH="next"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+diet static-libs"

src_configure() {
	local mycmakeargs=(
		-DCAPSTONE_BUILD_DIET="$(usex diet)"
		-DCAPSTONE_BUILD_STATIC="$(usex static-libs)"
		-DCAPSTONE_INSTALL=ON
		-DCAPSTONE_ARCHITECTURE_DEFAULT=OFF
		-DCAPSTONE_ARM64_SUPPORT=ON
		-DCAPSTONE_X86_SUPPORT=ON
	)
	cmake_src_configure
}
