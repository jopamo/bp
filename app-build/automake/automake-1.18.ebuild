# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR=${PV%%.*}
MINOR=${PV##*.}

OLDVER1="$MAJOR.$((MINOR - 1))"
OLDVER2="$MAJOR.$((MINOR - 2))"

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"
BDEPEND="
	app-build/autoconf
	app-build/gnuconfig
	app-core/help2man
"

src_install() {
	emake DESTDIR="${D}" install || die

	rm "${ED}"/usr/bin/{aclocal,automake}-* || die

	VERSIONS=("${OLDVER1}" "${OLDVER2}" "$(ver_cut 1-2)")

	for v in "${VERSIONS[@]}"; do
		dosym -r /usr/bin/aclocal /usr/bin/aclocal-${v}
		dosym -r /usr/bin/automake /usr/bin/automake-${v}
	done

	dosym -r /usr/share/gnuconfig/config.sub   /usr/share/automake-$(ver_cut 1-2)/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/automake-$(ver_cut 1-2)/config.guess

	for dir in aclocal automake; do
		mkdir -p "${ED}/usr/share/${dir}" || die
		cp -rp "${ED}/usr/share/${dir}-$(ver_cut 1-2)"/* "${ED}/usr/share/${dir}/" || die
		rm -rf "${ED}/usr/share/${dir}-$(ver_cut 1-2)" || die
		dosym -r /usr/share/${dir} /usr/share/${dir}-$(ver_cut 1-2)
	done

	rm "${ED}"/usr/share/doc/automake-1.18/amhello-1.0.tar.gz
}
