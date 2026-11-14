# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}/cpio-preserve-mtime.patch"
	"${FILESDIR}/archiver-test-prerequisites.patch"
)

COMMON_DEPEND="
	app-build/autoconf
	app-lang/perl
"
RDEPEND="
	${COMMON_DEPEND}
	app-build/gnuconfig
"
BDEPEND="
	${COMMON_DEPEND}
"

src_compile() {
	# Build matching generators before regenerating patched release macros.
	emake -o aclocal.m4 -o configure -o Makefile.in \
		bin/aclocal-$(ver_cut 1-2) bin/automake-$(ver_cut 1-2) \
		lib/Automake/Config.pm
	default
}

src_test() {
	emake check
}

src_install() {
	default

	mkdir -p "${ED}"/usr/share/{aclocal,automake} || die

	cp -rp "${ED}"/usr/share/aclocal-$(ver_cut 1-2)/. "${ED}"/usr/share/aclocal/ || die
	cp -rp "${ED}"/usr/share/automake-$(ver_cut 1-2)/. "${ED}"/usr/share/automake/ || die

	rm -rf "${ED}"/usr/share/{aclocal,automake}-$(ver_cut 1-2) || die

	dosym -r /usr/share/aclocal /usr/share/aclocal-$(ver_cut 1-2)
	dosym -r /usr/share/automake /usr/share/automake-$(ver_cut 1-2)

	rm "${ED}"/usr/share/automake/config.sub || die
	rm "${ED}"/usr/share/automake/config.guess || die
	dosym -r /usr/share/gnuconfig/config.sub /usr/share/automake/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/automake/config.guess
}
