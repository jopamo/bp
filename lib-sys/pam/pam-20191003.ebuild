# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps autotools

DESCRIPTION="Linux-PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.linux-pam.org/ https://fedorahosted.org/linux-pam/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linux-pam/linux-pam.git"
else
	SNAPSHOT=727799854ebfc5dea5006ec374f01ad4c0889783
	SRC_URI="https://github.com/linux-pam/linux-pam/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/linux-${PN}-${SNAPSHOT}
fi

LICENSE="|| ( BSD GPL-2 )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="audit debug nls test vim-syntax"

BDEPEND="app-misc/w3m
		app-text/docbook-xml-dtd:4.1
		app-text/docbook-xml-dtd:4.3
		app-text/docbook-xml-dtd:4.4
		app-text/docbook-sgml-dtd:4.5"

RDEPEND="
	audit? ( >=sys-app/audit-2.2.2 )"

PDEPEND="
	lib-sys/pambase
	vim-syntax? ( app-misc/vim )"

src_prepare() {
	touch ChangeLog
	default
	eautoreconf
}

src_configure() {
	export ac_cv_header_xcrypt_h=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-securedir="${EPREFIX}"/usr/lib/security
		$(use_enable nls)
		$(use_enable audit)
		$(use_enable debug)
		--disable-db
		--disable-prelude
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake sepermitlockdir="${EPREFIX}/run/sepermit"
}

src_install() {
	emake DESTDIR="${D}" install \
		sepermitlockdir="${EPREFIX}/run/sepermit"

	cleanup_install
}

pkg_postinst() {
	fcaps cap_dac_override usr/sbin/unix_chkpwd
}
