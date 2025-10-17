# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_UPSTREAM_PEP517=standalone
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit cargo distutils-r1 flag-o-matic toolchain-funcs

DESCRIPTION="Build and publish crates with pyo3, rust-cpython and cffi bindings"
HOMEPAGE="https://www.maturin.rs/"
SNAPSHOT=7a57d244c3fac45ea4d2f16f10c94c604dcc4668
SRC_URI="https://github.com/PyO3/maturin/archive/${SNAPSHOT}.tar.gz -> maturin-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/maturin-${SNAPSHOT}"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND="
	virtual/rust
	dev-py/setuptools-rust
"

QA_FLAGS_IGNORED="usr/bin/maturin"

src_prepare() {
	export OPENSSL_NO_VENDOR=1

	use elibc_musl && RUSTFLAGS+=" -C target-feature=-crt-static"

	distutils-r1_src_prepare
}
