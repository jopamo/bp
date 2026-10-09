# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_13 )

inherit meson git-r3 python-r1 qa-policy

DESCRIPTION="Vesk SSL/TLS, crypto, and native password-hashing libraries"
HOMEPAGE="https://gitlab.com/pjo/vesk"
EGIT_REPO_URI="https://gitlab.com/pjo/vesk.git/"

LICENSE="ISC LGPL-2.1+ LGPL-3+ MIT || ( Apache-2.0 CC0-1.0 ) || ( Apache-2.0 BSD ) PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+gnutls +shared +static-libs"
REQUIRED_USE="shared ${PYTHON_REQUIRED_USE}"

# CPython imports these extensions by path; no library links against them.
QA_POLICY_ELF_ALLOW_MISSING_SONAME='^/usr/lib/python3\.13/site-packages/cryptography/hazmat/bindings/_(openssl|padding)\.abi3\.so$'

DEPEND="
	${PYTHON_DEPS}
	lib-core/libgpg-error
	gnutls? ( lib-core/gmp )
	elibc_musl? ( lib-core/musl[libxcrypt] )
"
RDEPEND="
	${DEPEND}
	dev-pypi/cffi[${PYTHON_USEDEP}]
	dev-pypi/six[${PYTHON_USEDEP}]
	!app-crypto/argon2
	!app-crypto/cryptography
	!lib-core/libgcrypt
	!lib-core/libxcrypt
	!lib-core/libxcrypt-compat
"
BDEPEND="
	${PYTHON_DEPS}
	app-lang/perl
	dev-pypi/cffi[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/six[${PYTHON_USEDEP}]
"

src_configure() {
	qa-policy-configure
	python_setup

	local emesonargs=(
		-Ddefault_library=$(usex shared $(usex static-libs both shared) static)
		-Ddefault_ca_file=/etc/ssl/certs/ca-certificates.crt
		-Dgnutls=$(usex gnutls enabled disabled)
		-Dlibcrypt=enabled
		-Dlibcrypt-compat=enabled
		-Dopenssldir=/etc/ssl
		-Dpython="${EPYTHON}"
		-Dpython-cryptography=enabled
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
