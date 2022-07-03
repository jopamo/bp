# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION=" Linux PAM (Pluggable Authentication Modules for Linux) project"
HOMEPAGE="https://github.com/linux-pam/linux-pam"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SNAPSHOT=31645f4830162a3dd49513b74a5e56f40777e98c
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/linux-${PN}-${SNAPSHOT}
fi

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug musl"

BDEPEND="
	app-build/flex
	app-tex/docbook-sgml-dtd:4.5
	app-tex/docbook-xml-dtd:4.1
	app-tex/docbook-xml-dtd:4.3
	app-tex/docbook-xml-dtd:4.4
	app-var/w3m
"

DEPEND="lib-net/libtirpc"
PDEPEND="app-core/pambase"

src_prepare() {
	touch ChangeLog

	default
	eautoreconf

	#this requires termio.h, which is missing on musl
	if use musl ; then
		sed -i -e 's/tty_conv//' "examples/Makefile.am" || die
	fi
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
