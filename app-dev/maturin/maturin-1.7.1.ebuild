# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Build and publish crates with pyo3, rust-cpython and cffi bindings"
HOMEPAGE="https://www.maturin.rs/"
SRC_URI="https://github.com/PyO3/maturin/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

# note: rustls+ring is unused, so openssl license can be skipped
LICENSE="|| ( Apache-2.0 MIT ) doc? ( CC-BY-4.0 OFL-1.1 )"
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT MPL-2.0
	Unicode-DFS-2016
" # crates
SLOT="0"
KEYWORDS="amd64 arm ~arm64 ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="doc +ssl test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/setuptools-rust
	test? (
		${RDEPEND}
		$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
		dev-python/boltons[${PYTHON_USEDEP}]
		dev-python/virtualenv[${PYTHON_USEDEP}]
	)
"
RDEPEND+=" ${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	export OPENSSL_NO_VENDOR=1

	use elibc_musl && RUSTFLAGS+=" -C target-feature=-crt-static"

	distutils-r1_src_prepare

	cargo fetch --locked
}
