# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 qa-policy

DESCRIPTION="Vesk OpenSSL-compatible SSL/TLS and crypto libraries"
HOMEPAGE="https://gitlab.com/pjo/vesk"
EGIT_REPO_URI="https://gitlab.com/pjo/vesk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+shared +static-libs"
REQUIRED_USE="|| ( shared static-libs )"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Ddefault_library=$(usex shared $(usex static-libs both shared) static)
		-Ddefault_ca_file=/etc/ssl/certs/ca-certificates.crt
		-Dopenssldir=/etc/ssl
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
