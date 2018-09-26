# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib user flag-o-matic eutils pam toolchain-funcs autotools systemd versionator

DESCRIPTION="Lightweight but featured SMTP daemon from OpenBSD"
HOMEPAGE="https://www.opensmtpd.org"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/OpenSMTPD/OpenSMTPD.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=96df5cee6291fed387abc1e42aeae9e3fa94ebf7
	SRC_URI="https://github.com/OpenSMTPD/OpenSMTPD/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/OpenSMTPD-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
IUSE="libressl pam +mta"

DEPEND="!libressl? ( lib-dev/openssl:0 )
		libressl? ( lib-dev/libressl )
		elibc_musl? ( lib-sys/fts-standalone )
		lib-sys/zlib
		pam? ( lib-sys/pam )
		lib-dev/libevent
		app-misc/ca-certificates
		app-net/mailbase
		lib-net/libasr
		!app-net/courier
		!app-net/esmtp
		!app-net/exim
		!app-net/mini-qmail
		!app-net/msmtp[mta]
		!app-net/netqmail
		!app-net/nullmailer
		!app-net/postfix
		!app-net/qmail-ldap
		!app-net/sendmail
		!app-net/ssmtp[mta]
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	tc-export AR
	AR="$(which "$AR")" econf \
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
		dosym /usr/sbin/smtpctl /usr/$(get_libdir)/sendmail
	fi
}

pkg_preinst() {
	enewgroup smtpd 25
	enewuser smtpd 25 -1 /var/empty smtpd
	enewgroup smtpq 252
	enewuser smtpq 252 -1 /var/empty smtpq
}
