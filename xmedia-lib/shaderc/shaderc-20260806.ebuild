# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic qa-policy

DESCRIPTION="Collection of tools, libraries and tests for shader compilation"
HOMEPAGE="https://github.com/google/shaderc"

SNAPSHOT=2c8cae778eec0283b44acbe7ed1a386865d78799
SRC_URI="https://github.com/google/shaderc/archive/${SNAPSHOT}.tar.gz -> shaderc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/shaderc-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=test

BDEPEND="app-lang/python"

DEPEND="
	app-dev/glslang
	app-dev/spirv-tools
"

PATCHES=(
	"${FILESDIR}"/shaderc-20260806-system-deps.patch
	"${FILESDIR}"/shaderc-20260806-fix-build.patch
)

src_prepare() {
	append-flags -ffat-lto-objects

	cmake_comment_add_subdirectory examples

	# Unbundle glslang, spirv-headers, spirv-tools
	sed -i \
		-e "s|\$<TARGET_FILE:spirv-dis>|${EPREFIX}/usr/bin/spirv-dis|" \
		glslc/test/CMakeLists.txt || die

	# Disable git versioning
	sed -i -e '/build-version/d' glslc/CMakeLists.txt || die

	# Manually create build-version.inc as we disabled git versioning
	cat <<- EOF > glslc/src/build-version.inc || die
		"${P}\n"
		"$(best_version app-dev/spirv-tools)\n"
		"$(best_version app-dev/glslang)\n"
	EOF

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSHADERC_ENABLE_WERROR_COMPILE="false"
		-DSHADERC_SKIP_TESTS="true"
		-DSHADERC_SKIP_EXAMPLES="true"
		-DSHADERC_SYSTEM_INCLUDE_DIR="${ESYSROOT}/usr/include"
		-DSHADERC_SYSTEM_PREFIX="${ESYSROOT}/usr"
	)

	qa-policy-configure
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
