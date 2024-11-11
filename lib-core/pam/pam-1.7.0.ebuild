# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Linux PAM (Pluggable Authentication Modules for Linux) project"
HOMEPAGE="https://github.com/linux-pam/linux-pam"
SRC_URI="https://github.com/linux-pam/linux-pam/releases/download/v${PV}/Linux-PAM-${PV}.tar.xz"

S="${WORKDIR}/Linux-PAM-${PV}"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="musl logind"

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
	default

	# This requires termio.h, which is missing on musl
	if use musl ; then
		sed -i -e 's/tty_conv//' "examples/Makefile.am" || die
	fi
}

src_configure() {
	local emesonargs=(
		-Ddebug=false
		$(meson_feature logind)
		-Dsecuredir="${EPREFIX}/usr/lib/security"
	)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install

	chmod +s "${ED}"/usr/sbin/unix_chkpwd
}
