# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU macro processor"
HOMEPAGE="https://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="app-compression/xz-utils"

PATCHES=( ${FILESDIR}/0001-fflush-adjust-to-glibc-2.28-libio.h-removal.patch )

src_configure() {
	# Disable automagic dependency over libsigsegv; see bug #278026
	export ac_cv_libsigsegv=no

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	econf --enable-changeword ${myconf}
}

src_test() {
	[[ -d /none ]] && die "m4 tests will fail with /none/" #244396
	emake check
}

src_install() {
	default

	use prefix && dosym /usr/bin/m4 /usr/bin/gm4
}
