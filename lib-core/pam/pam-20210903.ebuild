# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Linux-PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.linux-pam.org/ https://fedorahosted.org/linux-pam/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linux-pam/linux-pam.git"
else
	SNAPSHOT=40f7d85f3736d058c26de1dafa4fed46de7d75ef
	SRC_URI="https://github.com/linux-pam/linux-pam/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/linux-${PN}-${SNAPSHOT}
fi

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

BDEPEND="
	sys-devel/flex
	app-misc/w3m
	app-text/docbook-xml-dtd:4.1
	app-text/docbook-xml-dtd:4.3
	app-text/docbook-xml-dtd:4.4
	app-text/docbook-sgml-dtd:4.5
"

DEPEND="
	lib-net/libtirpc
	lib-core/libxcrypt
"
PDEPEND="app-core/pambase"

src_prepare() {
	touch ChangeLog
	default
	eautoreconf
}

src_configure() {
	export ac_cv_header_xcrypt_h=no

	local myconf=(
		--enable-securedir="${EPREFIX}"/usr/lib/security
		$(use_enable debug)
		--disable-db
		--disable-prelude
		--disable-nls
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake sepermitlockdir="${EPREFIX}/run/sepermit"
}

src_install() {
	emake DESTDIR="${ED}" install \
		sepermitlockdir="${EPREFIX}/run/sepermit"

	cleanup_install

	chmod +s "${ED}"/usr/sbin/unix_chkpwd
}
