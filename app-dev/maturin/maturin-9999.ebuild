# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 cargo git-r3

DESCRIPTION="Build and publish crates with pyo3, rust-cpython and cffi bindings"
HOMEPAGE="https://www.maturin.rs/"
EGIT_REPO_URI="https://github.com/PyO3/maturin"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
#KEYWORDS="amd64 arm64"

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
