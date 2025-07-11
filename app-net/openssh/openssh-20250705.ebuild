# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools doins

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.org/"
SNAPSHOT=c971f3d93efe4c00d73b276cdbab66e7c66c9b5c
SRC_URI="https://github.com/openssh/openssh-portable/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/openssh-portable-${SNAPSHOT}

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug pam pie scp ssl static systemd test tmpfilesd utmpx wtmpx"

DEPEND="
	app-core/shadow
	lib-core/libedit
	lib-core/libseccomp
	lib-core/zlib
	pam? ( lib-core/pam )
	ssl? ( virtual/ssl )
"
BDEPEND="
	app-build/autoconf
	app-dev/pkgconf
	virtual/linux-sources
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use debug && append-cppflags -DSANDBOX_SECCOMP_FILTER_DEBUG
	use static && append-ldflags -static

	local myconf=(
		--datadir="${EPREFIX}"/usr/share/openssh
		--sbindir="${EPREFIX}"/usr/bin
		--sysconfdir="${EPREFIX}"/etc/ssh
		--with-ldflags="${LDFLAGS}"
		--with-pid-dir="${EPREFIX}"/run
		--with-privsep-path="${EPREFIX}"/var/empty
		--with-privsep-user="sshd"
		--with-sandbox="seccomp_filter"
		$(use_enable utmpx)
		$(use_enable wtmpx)
		$(use_with pam)
		$(use_with ssl openssl)
		$(use_with ssl ssl-engine)
		--disable-strip
		--disable-utmp
		--disable-wtmp
		--with-libedit
		--with-pie
		--without-audit
		--without-rpath
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake install-nokeys DESTDIR="${D}"

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/sshd.pam" sshd
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/sshdgenkeys.service
		doins "${FILESDIR}"/sshd.service
	fi

	insinto /etc/ssh
	doins "${FILESDIR}"/{ssh,sshd}_config

	keepdir /var/empty

	fperms 644 /etc/ssh/{ssh,sshd}_config

	#generate this outside of installation
	rm -rf "${ED}"/etc/ssh/moduli || die

	use scp || rm "${ED}"/usr/bin/scp || die

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins "${FILESDIR}/openssh-tmpfiles" openssh.conf
	fi

	dobin contrib/ssh-copy-id
	doman contrib/ssh-copy-id.1
}

pkg_preinst() {
	newsysusers "${FILESDIR}/${PN}-sysusers" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
}
