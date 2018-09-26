# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user flag-o-matic multilib-minimal autotools pam systemd versionator

MY_PV="$(replace_all_version_separators _)"

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.org/"
SRC_URI="https://github.com/rapier1/openssh-portable/archive/hpn-${MY_PV^^}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="audit bindist debug libedit libressl pam +pie sctp selinux +ssl static test X"
REQUIRED_USE="pie? ( !static )
	static? ( !pam )
	test? ( ssl )"

LIB_DEPEND="
	audit? ( sys-app/audit[static-libs(+)] )
	libedit? ( lib-dev/libedit:=[static-libs(+)] )
	sctp? ( app-net/lksctp-tools[static-libs(+)] )
	selinux? ( >=lib-sys/libselinux-1.28[static-libs(+)] )
	ssl? (
		!libressl? (
			>=lib-dev/openssl-1.0.1:0=[bindist=]
			lib-dev/openssl:0=[static-libs(+)]
		)
		libressl? ( lib-dev/libressl:0=[static-libs(+)] )
	)
	>=lib-sys/zlib-1.2.3:=[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	pam? ( lib-sys/pam )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	dev-util/pkgconfig
	lib-sys/libseccomp
	sys-kernel/stable-sources
	sys-devel/autoconf"

RDEPEND="${RDEPEND}
	pam? ( >=lib-sys/pambase-20081028 )
	sys-app/shadow
	X? ( x11/xauth )"

S="${WORKDIR}/${PN}-portable-hpn-${MY_PV^^}"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	use debug && append-cppflags -DSANDBOX_SECCOMP_FILTER_DEBUG
	use static && append-ldflags -static

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--localstatedir="${EPREFIX}"/var
		--with-pid-dir="${EPREFIX}"/run
		--with-ldflags="${LDFLAGS}"
		--disable-strip
		--sysconfdir="${EPREFIX}"/etc/ssh
		--datadir="${EPREFIX}"/usr/share/openssh
		--with-privsep-path="${EPREFIX}"/var/empty
		--with-privsep-user="sshd"
		--with-sandbox="seccomp_filter"
		$(use_with audit audit linux)
		$(use_with libedit)
		$(use_with pam)
		$(use_with pie)
		$(use_with selinux)
		$(use_with ssl openssl)
		$(use_with ssl ssl-engine)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	emake install-nokeys DESTDIR="${D}"

	newpamd "${FILESDIR}"/sshd.pam_include.2 sshd

	systemd_dounit "${FILESDIR}"/sshd.socket
	mkdir -p "${ED}"/etc/systemd/system/
	cp "${FILESDIR}"/sshd.socket "${ED}"/etc/systemd/system/
	systemd_dounit "${FILESDIR}"/sshdgenkeys.service
	systemd_newunit "${FILESDIR}"/sshd_at.service 'sshd@.service'

	cp "${FILESDIR}"/sshd_config "${ED}"/etc/ssh/
	fperms 600 /etc/ssh
	keepdir /var/empty
	rm -rf "${ED}"/etc/ssh/moduli
}

pkg_preinst() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}
