# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 qa-policy

DESCRIPTION="Vesk SSL/TLS, crypto, and native password-hashing libraries"
HOMEPAGE="https://gitlab.com/pjo/vesk"
EGIT_REPO_URI="https://gitlab.com/pjo/vesk"

LICENSE="ISC LGPL-2.1+ LGPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+gnutls +shared +static-libs"
REQUIRED_USE="shared"

DEPEND="
	gnutls? ( lib-core/gmp )
	elibc_musl? ( lib-core/musl[libxcrypt] )
"
RDEPEND="
	${DEPEND}
	!lib-core/libxcrypt
"
BDEPEND="app-lang/perl"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Ddefault_library=$(usex shared $(usex static-libs both shared) static)
		-Ddefault_ca_file=/etc/ssl/certs/ca-certificates.crt
		-Dgnutls=$(usex gnutls enabled disabled)
		-Dlibcrypt=enabled
		-Dopenssldir=/etc/ssl
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
