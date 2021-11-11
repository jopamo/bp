# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION=" Linux PAM (Pluggable Authentication Modules for Linux) project"
HOMEPAGE="https://github.com/linux-pam/linux-pam"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SNAPSHOT=40f7d85f3736d058c26de1dafa4fed46de7d75ef
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/linux-${PN}-${SNAPSHOT}
fi

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

BDEPEND="
	app-build/flex
	app-var/w3m
	app-tex/docbook-xml-dtd:4.1
	app-tex/docbook-xml-dtd:4.3
	app-tex/docbook-xml-dtd:4.4
	app-tex/docbook-sgml-dtd:4.5
"

DEPEND="lib-net/libtirpc"
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
