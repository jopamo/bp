# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release/$(ver_cut 1).x"

inherit cmake python-any-r1

DESCRIPTION="Implementation of OpenCL C built-in libraries for GPU/OpenCL compilers"
HOMEPAGE="https://llvm.org/"
SNAPSHOT=21ef2ddb806006eba611b8a769ae72e5f86f9418
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-project-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/libclc"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="+spirv video_cards_nvidia video_cards_radeonsi"
REQUIRED_USE="|| ( spirv video_cards_nvidia video_cards_radeonsi )"

BDEPEND="
	${PYTHON_DEPS}
	>=app-build/llvm-23:0
	<app-build/llvm-24:0
	spirv? ( xgui-tools/spirv-llvm-translator )
"

DEPEND="
	>=app-build/llvm-23:0
	<app-build/llvm-24:0
"

CMAKE_BUILD_TYPE=Release

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	libclc_targets=()

	use spirv && libclc_targets+=(
		"spirv32-unknown-unknown"
		"spirv64-unknown-unknown"
	)
	use video_cards_nvidia && libclc_targets+=(
		"nvptx64--"
		"nvptx64--nvidiacl"
	)
	use video_cards_radeonsi && libclc_targets+=(
		"amdgcn--"
		"amdgcn-mesa-mesa3d"
		"amdgcn--amdhsa"
	)
	[[ ${#libclc_targets[@]} ]] || die "libclc target missing!"

	local target
	for target in "${libclc_targets[@]}"; do
		local BUILD_DIR="${WORKDIR}/${PN}-${target}_build"
		local mycmakeargs=(
			-DCMAKE_CLC_COMPILER="${BROOT}/usr/bin/clang"
			-DLLVM_DEFAULT_TARGET_TRIPLE="${target}"
			-DLLVM_DIR="${ESYSROOT}/usr/lib/cmake/llvm"
		)
		cmake_src_configure
	done
}

src_compile() {
	local target
	for target in "${libclc_targets[@]}"; do
		local BUILD_DIR="${WORKDIR}/${PN}-${target}_build"
		cmake_src_compile
	done
}

src_install() {
	local target
	for target in "${libclc_targets[@]}"; do
		local BUILD_DIR="${WORKDIR}/${PN}-${target}_build"
		cmake_src_install
	done

	if use spirv; then
		dosym -r /usr/share/clc/spirv32-unknown-unknown/libclc.spv \
			/usr/share/clc/spirv-mesa3d-.spv
		dosym -r /usr/share/clc/spirv64-unknown-unknown/libclc.spv \
			/usr/share/clc/spirv64-mesa3d-.spv
	fi

	cat > "${T}/libclc.pc" <<-EOF || die
	prefix=${EPREFIX}/usr
	libexecdir=\${prefix}/share/clc

	Name: libclc
	Description: OpenCL C built-in libraries
	Version: 0.2.0
	EOF
	insinto /usr/lib/pkgconfig
	doins "${T}/libclc.pc"
}
