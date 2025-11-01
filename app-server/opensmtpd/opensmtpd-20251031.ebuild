# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user toolchain-funcs autotools

DESCRIPTION="Lightweight but featured SMTP daemon from OpenBSD"
HOMEPAGE="https://www.opensmtpd.org"
SNAPSHOT=6582e2d45e59412096716f733c07e69500c4d57c
SRC_URI="https://github.com/OpenSMTPD/OpenSMTPD/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/OpenSMTPD-${SNAPSHOT}

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam mta systemd"

DEPEND="
	app-net/mailbase
	lib-core/zlib
	lib-dev/libevent
	pam? ( lib-core/pam )
	virtual/ssl
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
