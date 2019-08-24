# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd toolchain-funcs

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
HOMEPAGE="http://vsftpd.beasts.org/"
SRC_URI="https://security.appspot.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="caps pam ssl xinetd"

DEPEND="lib-sys/libcap
	pam? ( lib-sys/pam )
	ssl? ( virtual/ssl )
"
RDEPEND="${DEPEND}
	xinetd? ( sys-app/xinetd )"

src_prepare() {
	# Configure vsftpd build defaults
	use ssl && echo "#define VSF_BUILD_SSL" >> builddefs.h
	use pam || echo "#undef VSF_BUILD_PAM" >> builddefs.h

	# Let portage control stripping
	sed -i '/^LINK[[:space:]]*=[[:space:]]*/ s/-Wl,-s//' Makefile || die

	eapply_user
}

src_compile() {
	# Override LIBS variable. Bug #508192
	LIBS=
	use caps && LIBS+=" -lcap"
	use pam && LIBS+=" -lpam"
	use ssl && LIBS+=" -lssl -lcrypto"

	CFLAGS="${CFLAGS}" \
	CC="$(tc-getCC)" \
	emake LIBS="${LIBS}"
}

src_install() {
	into /usr
	doman ${PN}.conf.5 ${PN}.8
	dosbin ${PN} || die "disbin failed"

	newdoc ${PN}.conf ${PN}.conf.example

	docinto security
	dodoc SECURITY/* || die "dodoc failed"

	insinto "/usr/share/doc/${PF}/examples"
	doins -r EXAMPLE/* || die "doins faileD"

	insinto /etc/${PN}
	newins ${PN}.conf{,.example}

	keepdir /usr/share/${PN}/empty

	exeinto /usr/libexec
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_newunit "${FILESDIR}/${PN}_at.service" "${PN}@.service"
	systemd_dounit "${FILESDIR}/${PN}.socket"

	cleanup_install
}
