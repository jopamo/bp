# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v2.58"
inherit toolchain-funcs flag-o-matic qa-policy

DESCRIPTION="UASM is a free MASM-compatible assembler"
HOMEPAGE="https://www.terraspace.co.uk/uasm.html"

SNAPSHOT=fa7add4042f11050aee97150caa17a9ef699c600
SRC_URI="https://github.com/Terraspace/UASM/archive/${SNAPSHOT}.tar.gz -> uasm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/UASM-${SNAPSHOT}"

LICENSE="Watcom-1.0"
SLOT="0"
KEYWORDS="amd64"

PATCHES=(
	"${FILESDIR}/bool-fix.diff"
	"${FILESDIR}/c-compat.patch"
)

src_prepare() {
	default
	# don't strip binary
	sed -i Makefile-Linux-GCC-64.mak -e 's/ -s / /g' || die
}

src_compile() {
	qa-policy-configure

	append-cflags -std=gnu17 -fcommon
	append-cflags -Wno-error=incompatible-pointer-types

	emake -f Makefile-Linux-GCC-64.mak \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin GccUnixR/uasm
	qa-policy-install
}
