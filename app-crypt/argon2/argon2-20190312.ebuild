# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=e4ca309b044fdc6ec547a3e1a106b4bfd06563b4

DESCRIPTION="Password hashing software that won the Password Hashing Competition (PHC)"
HOMEPAGE="https://github.com/P-H-C/phc-winner-argon2"
SRC_URI="https://github.com/P-H-C/phc-winner-argon2/archive/${SNAPSHOT}.zip -> ${P}.zip"

LICENSE="|| ( Apache-2.0 CC0-1.0 )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

S=${WORKDIR}/phc-winner-${PN}-${SNAPSHOT}

src_prepare() {
	default
	if ! use static-libs; then
		sed -i -e 's/LIBRARIES = \$(LIB_SH) \$(LIB_ST)/LIBRARIES = \$(LIB_SH)/' Makefile || die "sed failed!"
	fi
	sed -i -e 's/-O3 //' -e 's/-g //' -e "s/-march=\$(OPTTARGET) /${CFLAGS} /" -e 's/CFLAGS += -march=\$(OPTTARGET)//' Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" LIBRARY_REL="lib64" install || die
}
