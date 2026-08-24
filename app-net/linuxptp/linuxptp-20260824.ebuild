# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="IEEE 1588 Precision Time Protocol implementation for Linux"
HOMEPAGE="https://github.com/richardcochran/linuxptp"
SNAPSHOT=227bbd4715bf4cb735be4947e987032f41457585
SRC_URI="https://github.com/richardcochran/linuxptp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps"

DEPEND="
	virtual/gnutls
	caps? ( lib-core/libcap )
"
RDEPEND="${DEPEND}"

RESTRICT="test"

linuxptp_make() {
	local incdefs feature
	incdefs=$(CC="$(tc-getCC)" ./incdefs.sh) || die

	# Do not let installed headers silently select undeclared libraries.
	for feature in NETTLE GNUTLS GNUPG OPENSSL LIBCAP; do
		incdefs=${incdefs//-DHAVE_${feature}/}
	done
	incdefs+=" -DHAVE_GNUTLS"
	use caps && incdefs+=" -DHAVE_LIBCAP"

	emake \
		CC="$(tc-getCC)" \
		EXTRA_CFLAGS="${CPPFLAGS} ${CFLAGS}" \
		EXTRA_LDFLAGS="${LDFLAGS}" \
		incdefs="${incdefs}" \
		version="${PV}" \
		"$@"
}

src_compile() {
	linuxptp_make
}

src_install() {
	linuxptp_make \
		DESTDIR="${ED}" \
		prefix="${EPREFIX}/usr" \
		sbindir="${EPREFIX}/usr/bin" \
		mandir="${EPREFIX}/usr/share/man" \
		install

	insinto /etc/linuxptp
	newins configs/default.cfg ptp4l.conf

	insinto /usr/share/linuxptp
	doins configs/*.cfg

	dodoc README.org
}
