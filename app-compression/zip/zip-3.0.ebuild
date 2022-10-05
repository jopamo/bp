# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

MY_P="${PN}${PV//.}"
DESCRIPTION="Info ZIP (encryption support)"
HOMEPAGE="http://www.info-zip.org/"
SRC_URI="mirror://sourceforge/infozip/${MY_P}.zip"
S="${WORKDIR}"/${MY_P}

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 crypt unicode"

DEPEND="${RDEPEND}"
RDEPEND="bzip2? ( app-compression/bzip2 )"
BDEPEND="app-compression/unzip"

PATCHES=(
	"${FILESDIR}"/${P}-no-crypt.patch
	"${FILESDIR}"/${P}-pic.patch
	"${FILESDIR}"/${P}-exec-stack.patch
	"${FILESDIR}"/${P}-build.patch
	"${FILESDIR}"/${P}-zipnote-freeze.patch
	"${FILESDIR}"/${P}-format-security.patch
	"${FILESDIR}"/${P}-clang-15-configure-tests.patch
)

src_configure() {
	append-cppflags \
		-DLARGE_FILE_SUPPORT \
		-DUIDGID_NOT_16BIT \
		-D$(usev !bzip2 'NO')BZIP2_SUPPORT \
		-D$(usev !crypt 'NO')CRYPT \
		-D$(usev !unicode 'NO')UNICODE_SUPPORT

	# - We use 'sh' because: 1. lacks +x bit, easier; 2. it tries to load bashdb
	# - Third arg disables bzip2 logic as we handle it ourselves above.
	sh ./unix/configure "$(tc-getCC)" "-I. -DUNIX ${CFLAGS} ${CPPFLAGS}" "${T}"

	if use bzip2 ; then
		sed -i -e "s:LFLAGS2=:&'-lbz2 ':" flags || die
	fi
}

src_compile() {
	emake \
		CPP="$(tc-getCPP)" \
		-f unix/Makefile generic
}

src_install() {
	dobin zip zipnote zipsplit
	doman man/zip{,note,split}.1
	if use crypt ; then
		dobin zipcloak
		doman man/zipcloak.1
	fi
}
