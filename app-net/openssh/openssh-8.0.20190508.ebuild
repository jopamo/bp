# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user flag-o-matic autotools pam systemd

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/openssh/openssh-portable.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=62dd70613b77b229f53db3cc1c3e8a206fa2b582
	SRC_URI="https://github.com/openssh/openssh-portable/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-portable-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD GPL-2"
SLOT="0"

IUSE="audit bindist debug libedit pam +pie retpoline +ssl static test X"
REQUIRED_USE="pie? ( !static )
	static? ( !pam )
	test? ( ssl )"

LIB_DEPEND="
	audit? ( sys-app/audit[static-libs(+)] )
	libedit? ( lib-dev/libedit:=[static-libs(+)] )
	ssl? ( >=lib-dev/openssl-1.0.1:0=[bindist=]	)
	>=lib-sys/zlib-1.2.3:=[static-libs(+)]"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	pam? ( lib-sys/pam )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	dev-util/pkgconf
	lib-sys/libseccomp
	sys-kernel/linux-headers
	sys-devel/autoconf"

RDEPEND="${RDEPEND}
	pam? ( lib-sys/pambase )
	sys-app/shadow
	X? ( x11-app/xauth )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use retpoline && append-flags "-mindirect-branch=thunk"
	use debug && append-cppflags -DSANDBOX_SECCOMP_FILTER_DEBUG
	use static && append-ldflags -static

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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
		$(use_with ssl openssl)
		$(use_with ssl ssl-engine)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake install-nokeys DESTDIR="${D}"

	newpamd "${FILESDIR}"/sshd.pam_include.2 sshd

	systemd_dounit "${FILESDIR}"/sshd.socket

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
