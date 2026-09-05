# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="HTML, DOM, CSS, and URL parsing library written in C"
HOMEPAGE="https://github.com/lexbor/lexbor"
SNAPSHOT=1c9970f57558a560b32f0031180687992b3e7989
SRC_URI="https://github.com/lexbor/lexbor/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/lexbor-static-library-name.patch"
)

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DLEXBOR_OPTIMIZATION_LEVEL=
		-DLEXBOR_BUILD_SHARED=ON
		-DLEXBOR_BUILD_STATIC=$(usex static-libs)
		-DLEXBOR_BUILD_TESTS=$(usex test)
		-DLEXBOR_BUILD_TESTS_CPP=OFF
		-DLEXBOR_BUILD_EXAMPLES=OFF
		-DLEXBOR_BUILD_BENCHMARKS=OFF
		-DLEXBOR_BUILD_UTILS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	local QA_POLICY_ARCHIVE_DUPLICATE_MEMBER_ALLOW="
		/usr/lib/liblexbor.a:attribute_steps.c.o
		/usr/lib/liblexbor.a:document.c.o
		/usr/lib/liblexbor.a:element.c.o
		/usr/lib/liblexbor.a:element_steps.c.o
		/usr/lib/liblexbor.a:encoding.c.o
		/usr/lib/liblexbor.a:error.c.o
		/usr/lib/liblexbor.a:interface.c.o
		/usr/lib/liblexbor.a:node.c.o
		/usr/lib/liblexbor.a:option_element.c.o
		/usr/lib/liblexbor.a:parser.c.o
		/usr/lib/liblexbor.a:selectors.c.o
		/usr/lib/liblexbor.a:serialize.c.o
		/usr/lib/liblexbor.a:state.c.o
		/usr/lib/liblexbor.a:style_element.c.o
		/usr/lib/liblexbor.a:tag.c.o
		/usr/lib/liblexbor.a:text.c.o
		/usr/lib/liblexbor.a:token.c.o
		/usr/lib/liblexbor.a:tokenizer.c.o
	"

	qa-policy-install
}
