# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user flag-o-matic autotools

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/openssh/openssh-portable.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=95401eea8503943449f712e5f3de52fc0bc612c5
	SRC_URI="https://github.com/openssh/openssh-portable/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-portable-${SNAPSHOT}
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug pam +pie +ssl static systemd test"

DEPEND="
	lib-core/libedit
	lib-core/libseccomp
	app-core/shadow
	lib-core/zlib
	pam? ( lib-core/pam )
	ssl? ( virtual/ssl )
"
BDEPEND="
	dev-util/pkgconf
	sys-kernel/linux-headers
	sys-devel/autoconf
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use debug && append-cppflags -DSANDBOX_SECCOMP_FILTER_DEBUG
	use static && append-ldflags -static

	local myconf=(
		--with-pid-dir="${EPREFIX}"/run
		--with-ldflags="${LDFLAGS}"
		--disable-strip
		--without-rpath
		--sysconfdir="${EPREFIX}"/etc/ssh
		--datadir="${EPREFIX}"/usr/share/openssh
		--with-privsep-path="${EPREFIX}"/var/empty
		--with-privsep-user="sshd"
		--with-sandbox="seccomp_filter"
		--with-libedit
		--without-audit
		--with-pie
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
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/sshdgenkeys.service
		doins "${FILESDIR}"/sshd.service
	fi

	insinto /etc/ssh
	doins "${FILESDIR}"/{ssh,sshd}_config

	mkdir -p "${ED}"/var/empty || die
	keepdir /var/empty

	fperms 600 /etc/ssh
	fperms 600 /var/empty

	#generate this outside of installation
	rm -rf "${ED}"/etc/ssh/moduli || die

	#scp has been deprecated
	rm -f "${ED}"/usr/bin/scp || die
}

pkg_preinst() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}
