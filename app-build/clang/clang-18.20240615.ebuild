# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

if [[ ${PV} == 18* ]] ; then
	SNAPSHOT="3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff"

elif [[ ${PV} == 13* ]] ; then
	SNAPSHOT="75e33f71c2dae584b13a7d1186ae0a038ba98838"

elif [[ ${PV} == 14* ]] ; then
	SNAPSHOT="f28c006a5895fc0e329fe15fead81e37457cb1d1"

elif [[ ${PV} == 15* ]] ; then
	SNAPSHOT="8dfdcc7b7bf66834a761bd8de445840ef68e4d1a"

elif [[ ${PV} == 16* ]] ; then
	SNAPSHOT="7cbf1a2591520c2491aa35339f227775f4d3adf6"

elif [[ ${PV} == 17* ]] ; then
	SNAPSHOT="6009708b4367171ccdbf4b5905cb6a803753fe18"

elif [[ ${PV} == 12* ]] ; then
	SNAPSHOT="fed41342a82f5a3a9201819a82bf7a48313e296b"
fi

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/clang"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="debug static-analyzer test"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

src_prepare() {
	# create extra parent dir for relative CLANG_RESOURCE_DIR access
	mkdir -p x/y || die
	BUILD_DIR=${WORKDIR}/x/y/clang

	cmake_src_prepare
}

check_distribution_components() {
	if [[ ${CMAKE_MAKEFILE_GENERATOR} == ninja ]]; then
		local all_targets=() my_targets=() l
		cd "${BUILD_DIR}" || die

		while read -r l; do
			if [[ ${l} == install-*-stripped:* ]]; then
				l=${l#install-}
				l=${l%%-stripped*}

				case ${l} in
					# meta-targets
					clang-libraries|distribution)
						continue
						;;
					# tools
					clang|clangd|clang-*)
						;;
					# static libraries
					clang*|findAllSymbols)
						continue
						;;
					# conditional to USE=doc
					docs-clang-html|docs-clang-tools-html)
						use doc || continue
						;;
				esac

				all_targets+=( "${l}" )
			fi
		done < <(${NINJA} -t targets all)

		while read -r l; do
			my_targets+=( "${l}" )
		done < <(get_distribution_components $"\n")

		local add=() remove=()
		for l in "${all_targets[@]}"; do
			if ! has "${l}" "${my_targets[@]}"; then
				add+=( "${l}" )
			fi
		done
		for l in "${my_targets[@]}"; do
			if ! has "${l}" "${all_targets[@]}"; then
				remove+=( "${l}" )
			fi
		done

		if [[ ${#add[@]} -gt 0 || ${#remove[@]} -gt 0 ]]; then
			eqawarn "get_distribution_components() is outdated!"
			eqawarn "   Add: ${add[*]}"
			eqawarn "Remove: ${remove[*]}"
		fi
		cd - >/dev/null || die
	fi
}

get_distribution_components() {
	local sep=${1-;}

	local out=(
		# common stuff
		clang-cmake-exports
		clang-headers
		clang-resource-headers
		libclang-headers

		aarch64-resource-headers
		arm-common-resource-headers
		arm-resource-headers
		core-resource-headers
		cuda-resource-headers
		hexagon-resource-headers
		hip-resource-headers
		hlsl-resource-headers
		mips-resource-headers
		opencl-resource-headers
		openmp-resource-headers
		ppc-htm-resource-headers
		ppc-resource-headers
		riscv-resource-headers
		systemz-resource-headers
		utility-resource-headers
		ve-resource-headers
		webassembly-resource-headers
		windows-resource-headers
		x86-resource-headers

		# libs
		clang-cpp
		libclang

		# common stuff
		bash-autocomplete
		libclang-python-bindings

		# tools
		amdgpu-arch
		c-index-test
		clang
		clang-format
		clang-linker-wrapper
		clang-offload-bundler
		clang-offload-packager
		clang-refactor
		clang-repl
		clang-rename
		clang-scan-deps
		diagtool
		hmaptool
		nvptx-arch

		# needed for cross-compiling Clang
		clang-tblgen

		# extra tools
		clang-apply-replacements
		clang-change-namespace
		clang-doc
		clang-include-cleaner
		clang-include-fixer
		clang-move
		clang-pseudo
		clang-query
		clang-reorder-fields
		clang-tidy
		clang-tidy-headers
		clangd
		find-all-symbols
		modularize
		pp-trace
	)

		use static-analyzer && out+=(
			clang-check
			clang-extdef-mapping
			scan-build
			scan-build-py
			scan-view
		)

	printf "%s${sep}" "${out[@]}"
}

src_configure() {
	replace-flags -O3 -O2

	strip-flags
	filter-lto

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_DISTRIBUTION_COMPONENTS=$(get_distribution_components)
		-DLLVM_EXTERNAL_CLANG_TOOLS_EXTRA_SOURCE_DIR="${WORKDIR}"/llvm-project-${SNAPSHOT}/clang-tools-extra
		-DCLANG_LINK_CLANG_DYLIB=ON
		-DCLANG_INCLUDE_TESTS=$(usex test)
		-DLLVM_TARGETS_TO_BUILD=llvm
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_INCLUDE_TESTS=OFF
		-DCLANG_DEFAULT_OPENMP_RUNTIME=libomp
		-DCMAKE_DISABLE_FIND_PACKAGE_CUDAToolkit=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_hsa-runtime64=ON
		-DCLANG_DEFAULT_PIE_ON_LINUX=ON
		-DCLANG_ENABLE_LIBXML2=ON
		-DCLANG_ENABLE_ARCMT=OFF
		-DCLANG_ENABLE_STATIC_ANALYZER=OFF
		-DPython3_EXECUTABLE="${PYTHON}"
	)

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_src_make check
}
