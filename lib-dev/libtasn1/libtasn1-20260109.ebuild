# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ASN.1 library"
HOMEPAGE="https://www.gnu.org/software/libtasn1/"
SNAPSHOT=eabf0fe9d7561e7863daa8e8212a1b5dc20dce10
SRC_URI="https://gitlab.com/gnutls/libtasn1/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib
	cd gnulib
	git reset --hard 92977
	cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
	default
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_enable valgrind valgrind-tests)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
