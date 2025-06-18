# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1).x"

inherit cmake flag-o-matic python-any-r1

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"
SNAPSHOT=cd708029e0b2869e80abe31ddb175f7c35361f90
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-project-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/libclc"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64"

IUSE="+spirv video_cards_nvidia video_cards_r600 video_cards_radeonsi"

BDEPEND="
	${PYTHON_DEPS}
	app-build/llvm
	spirv? ( xgui-tools/spirv-llvm-translator )
"

DEPEND="app-build/llvm"

CMAKE_BUILD_TYPE=Release

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	local libclc_targets=()

	use spirv && libclc_targets+=(
		"spirv-mesa3d-"
		"spirv64-mesa3d-"
	)
	use video_cards_nvidia && libclc_targets+=(
		"nvptx--"
		"nvptx64--"
		"nvptx--nvidiacl"
		"nvptx64--nvidiacl"
	)
	use video_cards_r600 && libclc_targets+=(
		"r600--"
	)
	use video_cards_radeonsi && libclc_targets+=(
		"amdgcn--"
		"amdgcn-mesa-mesa3d"
		"amdgcn--amdhsa"
	)
	[[ ${#libclc_targets[@]} ]] || die "libclc target missing!"

	libclc_targets=${libclc_targets[*]}
	local mycmakeargs=(
		-DLIBCLC_TARGETS_TO_BUILD="${libclc_targets// /;}"
	)
	cmake_src_configure
}


