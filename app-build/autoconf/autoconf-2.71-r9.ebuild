# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="https://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-build/m4
	app-lang/perl
"

PATCHES=(
	"${FILESDIR}"/${P}-AC_LANG_CALL_C_cxx.patch
	"${FILESDIR}"/${P}-time.patch
	"${FILESDIR}"/${P}-AC_C_BIGENDIAN-lto.patch
	"${FILESDIR}"/${P}-K-R-decls-clang.patch
	"${FILESDIR}"/${P}-make-4.4.patch
	"${FILESDIR}"/${P}-K-R-decls-clang-deux.patch
	"${FILESDIR}"/${P}-cxx11typo.patch
	"${FILESDIR}"/${P}-bash52.patch
)

src_install() {
	default

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/autoconf/build-aux/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/autoconf/build-aux/config.guess
}
