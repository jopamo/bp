# Distributed under the terms of the GNU General Public License v2

inherit qa-policy gl

DESCRIPTION="ASN.1 library"
HOMEPAGE="https://www.gnu.org/software/libtasn1/"
SNAPSHOT=2f560e2b0ddca402f8b19d8a7cfd02871ea26927
SRC_URI="https://gitlab.com/gnutls/libtasn1/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_prepare() {
	qa-policy-configure
	gl_stage_gnulib

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

src_install() {
	default
	qa-policy-install
}
