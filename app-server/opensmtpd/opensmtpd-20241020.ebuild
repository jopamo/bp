# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user toolchain-funcs autotools

DESCRIPTION="Lightweight but featured SMTP daemon from OpenBSD"
HOMEPAGE="https://www.opensmtpd.org"

SNAPSHOT=59723be46118b7200d4d64e33febab78d1d0933a
SRC_URI="https://github.com/OpenSMTPD/OpenSMTPD/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/OpenSMTPD-${SNAPSHOT}

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam +mta systemd"

DEPEND="
	virtual/ssl
	lib-core/zlib
	pam? ( lib-core/pam )
	lib-dev/libevent
	app-var/ca-certificates
	app-net/mailbase
	lib-dev/libasr
"

src_prepare() {
	default
	sed -i -e '/pidfile_path/s:_PATH_VARRUN:"/run/":' openbsd-compat/pidfile.c || die
	sed -i -e 's;/usr/libexec/;/usr/libexec/opensmtpd/;g' usr.sbin/smtpd/parse.y || die
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
		--sysconfdir=/etc/smtpd \
		$(use_with pam auth-pam)

}

src_install() {
	default

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins  "${FILESDIR}"/smtpd.{service,socket}
	fi

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/smtpd.pam" smtpd
	fi

	dosym /usr/sbin/smtpctl /usr/sbin/makemap
	dosym /usr/sbin/smtpctl /usr/sbin/newaliases

	if use mta ; then
		dodir /usr/sbin
		dosym /usr/sbin/smtpctl /usr/sbin/sendmail
		dosym /usr/sbin/smtpctl /usr/bin/sendmail
		dosym /usr/sbin/smtpctl /usr/lib/sendmail
	fi

	keepdir /var/spool/smtpd/offline/
}

pkg_preinst() {
	enewgroup smtpd 25
	enewuser smtpd 25 -1 /var/empty smtpd
	enewgroup smtpq 252
	enewuser smtpq 252 -1 /var/empty smtpq
}
