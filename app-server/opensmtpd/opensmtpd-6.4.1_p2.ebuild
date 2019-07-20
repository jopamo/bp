# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user flag-o-matic pam toolchain-funcs autotools systemd

DESCRIPTION="Lightweight but featured SMTP daemon from OpenBSD"
HOMEPAGE="https://www.opensmtpd.org"
SRC_URI="https://www.opensmtpd.org/archives/${P/_}.tar.gz"
S=${WORKDIR}/${P/_}

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="pam +mta"

DEPEND="lib-dev/libressl:0
		elibc_musl? ( lib-sys/fts-standalone )
		lib-sys/zlib
		pam? ( lib-sys/pam )
		lib-dev/libevent
		app-misc/ca-certificates
		app-net/mailbase
		lib-net/libasr
"
RDEPEND="${DEPEND}"

append-cppflags -D_DEFAULT_SOURCE

src_prepare() {
	default
	sed -i -e '/pidfile_path/s:_PATH_VARRUN:"/run/":' openbsd-compat/pidfile.c || die
	sed -i -e 's;/usr/libexec/;/usr/libexec/opensmtpd/;g' smtpd/parse.y || die
	eautoreconf
}

src_configure() {
	tc-export AR
	AR="$(which "$AR")" econf \
		--with-gnu-ld \
		--with-user-smtpd=smtpd \
		--with-user-queue=smtpq \
		--with-group-queue=smtpq \
		--with-path-socket=/run \
		--with-path-CAfile=/etc/ssl/certs/ca-certificates.crt \
		--sysconfdir=/etc/opensmtpd \
		$(use_with pam auth-pam)

}

src_install() {
	default
	systemd_dounit "${FILESDIR}"/smtpd.{service,socket}
	use pam && newpamd "${FILESDIR}"/smtpd.pam smtpd
	dosym /usr/sbin/smtpctl /usr/sbin/makemap
	dosym /usr/sbin/smtpctl /usr/sbin/newaliases
	if use mta ; then
		dodir /usr/sbin
		dosym /usr/sbin/smtpctl /usr/sbin/sendmail
		dosym /usr/sbin/smtpctl /usr/bin/sendmail
		dosym /usr/sbin/smtpctl /usr/lib64/sendmail
	fi
}

pkg_preinst() {
	enewgroup smtpd 25
	enewuser smtpd 25 -1 /var/empty smtpd
	enewgroup smtpq 252
	enewuser smtpq 252 -1 /var/empty smtpq
}
