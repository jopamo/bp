# Distributed under the terms of the GNU General Public License v2

EAPI=6

SNAPSHOT=20181220

inherit libtool eutils pam toolchain-funcs flag-o-matic db-use fcaps autotools

MY_PN="Linux-PAM"
BASEVERSION="1.3.1"

DESCRIPTION="Linux-PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.linux-pam.org/ https://fedorahosted.org/linux-pam/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linux-pam/linux-pam.git"
else
	SRC_URI="https://github.com/linux-pam/linux-pam/releases/download/v${BASEVERSION}/Linux-PAM-${BASEVERSION}.tar.xz
	https://1g4.org/files/pam-20181220.patch.tar.xz"
	S=${WORKDIR}/Linux-PAM-${BASEVERSION}
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="audit +cracklib debug nis nls +pie test vim-syntax"

RDEPEND="
	cracklib? ( >=lib-sys/cracklib-2.9.1-r1 )
	audit? ( >=sys-app/audit-2.2.2 )
	nis? ( >=lib-net/libtirpc-0.2.4-r2 )"

DEPEND="
	${RDEPEND}
	>=sys-devel/libtool-2
	>=sys-devel/flex-2.5.39-r1
	app-text/docbook-xml-dtd:4.3
	nis? ( >=dev-util/pkgconfig-0-r1 )"

PDEPEND="
	lib-sys/pambase
	vim-syntax? ( app-misc/vim )"

PATCHES=(
		"${WORKDIR}"/pam-${SNAPSHOT}.patch
)

src_configure() {
	export ac_cv_header_xcrypt_h=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-securedir="${EPREFIX}"/usr/lib64/security
		$(use_enable nls)
		$(use_enable cracklib)
		$(use_enable audit)
		$(use_enable debug)
		--disable-db
		$(use_enable nis)
		$(use_enable pie)
		--disable-prelude
	)

	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"
}

src_compile() {
	emake sepermitlockdir="${EPREFIX}/run/sepermit"
}

src_install() {
	emake DESTDIR="${D}" install \
		sepermitlockdir="${EPREFIX}/run/sepermit"
}

pkg_postinst() {
	fcaps cap_dac_override usr/sbin/unix_chkpwd
}
