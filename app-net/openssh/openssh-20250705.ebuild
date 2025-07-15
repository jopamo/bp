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

IUSE="debug pam pie ssl static systemd test"

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
		--disable-strip
		--disable-utmp
		--disable-utmpx
		--disable-wtmp
		--disable-wtmpx
		--with-libedit
		--with-pie
		--with-privsep-user="sshd"
		--with-sandbox="seccomp_filter"
		--with-wtmpdb
		--without-audit
		--without-rpath
		$(use_with pam)
		$(use_with ssl openssl)
		$(use_with ssl ssl-engine)
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
		systemd_dounit "${FILESDIR}"/sshdgenkeys.service
		systemd_dounit "${FILESDIR}"/sshd.service
	fi

	insinto /etc/ssh
	doins "${FILESDIR}"/{ssh,sshd}_config

	keepdir /var/empty

	fperms 644 /etc/ssh/{ssh,sshd}_config

	#generate this outside of installation
	rm -rf "${ED}"/etc/ssh/moduli || die

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		u sshd 22 "SSH drop priv user" /var/empty
	EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		d /var/empty 0755 root root
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"

	dobin contrib/ssh-copy-id
	doman contrib/ssh-copy-id.1
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
