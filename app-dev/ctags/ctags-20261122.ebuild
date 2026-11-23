# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="A maintained ctags implementation"
HOMEPAGE="https://ctags.io/"
SNAPSHOT=6397a2e66e9350f06c8d0f2d9fcf0cd0e3f9d913
SRC_URI="https://github.com/universal-ctags/ctags/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_CONFIG_IMPL_DECL_SKIP=(
	libiconv_open
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--disable-etags
		--enable-tmpdir=/tmp
	)
	econf "${econfargs[@]}"
}

PATCHES=( "${FILESDIR}/optscript-valgrind.patch" )
