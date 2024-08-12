# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Collection of tools, libraries and tests for shader compilation"
HOMEPAGE="https://github.com/google/shaderc"

SNAPSHOT=6d2848321250a19641800f8afb07738f3b0b7f18
SRC_URI="https://github.com/google/shaderc/archive/${SNAPSHOT}.tar.gz -> shaderc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/shaderc-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=test

RDEPEND="
	app-dev/glslang
	app-dev/spirv-tools
"

PATCHES=( "${FILESDIR}"/${PN}-2020.4-fix-build.patch )

src_prepare() {
	append-flags -ffat-lto-objects

	cmake_comment_add_subdirectory examples

	# Unbundle glslang, spirv-headers, spirv-tools
	cmake_comment_add_subdirectory third_party
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
		-DSHADERC_SKIP_TESTS="true"
		-DSHADERC_ENABLE_WERROR_COMPILE="false"
	)
	cmake_src_configure
}
