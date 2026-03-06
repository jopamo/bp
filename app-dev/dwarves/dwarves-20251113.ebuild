# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake python-single-r1

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF utilities"
HOMEPAGE="https://git.kernel.org/cgit/devel/pahole/pahole.git/"
SNAPSHOT=8b536f4ea4706f6e06db0567c18ce3f1c41c3f67
SRC_URI="https://github.com/acmel/dwarves/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dwarves-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

QA_GCC_WARN_SKIP=(
	# LTO inlining can report this cu__tag_free fallback path as a free-nonheap
	# issue even though DWARF mode uses tag__alloc/tag__free pairing.
	".*dwarves\\.c:66:17: warning: 'free' called on pointer '.*' with nonzero offset 64 \\[-Wfree-nonheap-object\\]"
)

DEPEND="
	lib-core/elfutils
	lib-net/libbpf:=
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	[[ -d "${WORKDIR}"/${P}-patches ]] && PATCHES+=( "${WORKDIR}"/${P}-patches )

	cmake_src_prepare
	python_fix_shebang ostra/ostra-cg ostra/python/ostra.py
}

src_configure() {
	local mycmakeargs=(
		-DLIBBPF_EMBEDDED=OFF
	)
	cmake_src_configure
}
