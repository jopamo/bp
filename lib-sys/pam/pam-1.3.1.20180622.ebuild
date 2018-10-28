# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool multilib multilib-minimal eutils pam toolchain-funcs flag-o-matic db-use fcaps

MY_PN="Linux-PAM"
BASEVERSION="1.3.1"
MY_P="${MY_PN}-${BASEVERSION}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Linux-PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.linux-pam.org/ https://fedorahosted.org/linux-pam/"
SRC_URI="https://github.com/linux-pam/linux-pam/releases/download/v${BASEVERSION}/Linux-PAM-${BASEVERSION}.tar.xz
		https://1g4.org/files/pam-20180622.patch.tar.xz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="audit +cracklib debug nis nls +pie selinux test vim-syntax"

RDEPEND="
	cracklib? ( >=lib-sys/cracklib-2.9.1-r1[${MULTILIB_USEDEP}] )
	audit? ( >=sys-app/audit-2.2.2[${MULTILIB_USEDEP}] )
	selinux? ( >=lib-sys/libselinux-2.2.2-r4[${MULTILIB_USEDEP}] )
	nis? ( >=lib-net/libtirpc-0.2.4-r2[${MULTILIB_USEDEP}] )"

DEPEND="
	${RDEPEND}
	>=sys-devel/libtool-2
	>=sys-devel/flex-2.5.39-r1[${MULTILIB_USEDEP}]
	nis? ( >=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}] )"

PDEPEND="
	lib-sys/pambase
	vim-syntax? ( app-misc/vim )"

PATCHES=( "${WORKDIR}/pam-20180622.patch" )

src_prepare() {
	eapply_user
	elibtoolize
}

multilib_src_configure() {
	export ac_cv_header_xcrypt_h=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-securedir="${EPREFIX}"/usr/$(get_libdir)/security
		$(use_enable nls)
		$(use_enable selinux)
		$(use_enable cracklib)
		$(use_enable audit)
		$(use_enable debug)
		--disable-db
		$(use_enable nis)
		$(use_enable pie)
		--with-db-uniquename=-$(db_findver lib-sys/db)
		--disable-prelude
		--disable-regenerate-docu
	)

	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"
}

multilib_src_compile() {
	emake sepermitlockdir="${EPREFIX}/run/sepermit"
}

multilib_src_install() {
	emake DESTDIR="${D}" install \
		sepermitlockdir="${EPREFIX}/run/sepermit"
}

pkg_postinst() {
	fcaps cap_dac_override usr/sbin/unix_chkpwd
}
