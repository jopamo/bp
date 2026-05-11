# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/aho-corasick-1.1.4
	rust-crates/anyhow-1.0.100
	rust-crates/attribute-derive-0.10.5
	rust-crates/attribute-derive-macro-0.10.5
	rust-crates/bitflags-2.10.0
	rust-crates/block-buffer-0.10.4
	rust-crates/bstr-1.12.1
	rust-crates/castaway-0.2.4
	rust-crates/cfg-if-1.0.4
	rust-crates/collection_literals-1.0.3
	rust-crates/compact_str-0.9.0
	rust-crates/cpufeatures-0.2.17
	rust-crates/crypto-common-0.1.7
	rust-crates/derive-where-1.6.0
	rust-crates/digest-0.10.7
	rust-crates/either-1.15.0
	rust-crates/equivalent-1.0.2
	rust-crates/generic-array-0.14.7
	rust-crates/get-size-derive2-0.7.4
	rust-crates/get-size2-0.7.4
	rust-crates/getopts-0.2.24
	rust-crates/getrandom-0.2.17
	rust-crates/hashbrown-0.16.1
	rust-crates/heck-0.5.0
	rust-crates/indexmap-2.13.0
	rust-crates/indoc-2.0.7
	rust-crates/interpolator-0.5.0
	rust-crates/is-macro-0.3.7
	rust-crates/itertools-0.14.0
	rust-crates/itoa-1.0.17
	rust-crates/libc-0.2.180
	rust-crates/log-0.4.29
	rust-crates/manyhow-0.11.4
	rust-crates/manyhow-macros-0.11.4
	rust-crates/memchr-2.7.6
	rust-crates/once_cell-1.21.3
	rust-crates/ordermap-1.1.0
	rust-crates/phf-0.11.3
	rust-crates/phf_codegen-0.11.3
	rust-crates/phf_generator-0.11.3
	rust-crates/phf_shared-0.11.3
	rust-crates/portable-atomic-1.13.0
	rust-crates/ppv-lite86-0.2.21
	rust-crates/proc-macro-utils-0.10.0
	rust-crates/proc-macro2-1.0.106
	rust-crates/pyo3-0.28.2
	rust-crates/pyo3-build-config-0.28.2
	rust-crates/pyo3-ffi-0.28.2
	rust-crates/pyo3-macros-0.28.2
	rust-crates/pyo3-macros-backend-0.28.2
	rust-crates/quote-1.0.44
	rust-crates/quote-use-0.8.4
	rust-crates/quote-use-macros-0.8.4
	rust-crates/rand-0.8.5
	rust-crates/rand_chacha-0.3.1
	rust-crates/rand_core-0.6.4
	rust-crates/regex-automata-0.4.13
	rust-crates/ruff_python_ast-0.0.0
	rust-crates/ruff_python_parser-0.0.0
	rust-crates/ruff_python_trivia-0.0.0
	rust-crates/ruff_source_file-0.0.0
	rust-crates/ruff_text_size-0.0.0
	rust-crates/rustc-hash-2.1.1
	rust-crates/rustversion-1.0.22
	rust-crates/ryu-1.0.22
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/sha1-0.10.6
	rust-crates/siphasher-1.0.1
	rust-crates/smallvec-1.15.1
	rust-crates/static_assertions-1.1.0
	rust-crates/syn-2.0.114
	rust-crates/target-lexicon-0.13.5
	rust-crates/thiserror-2.0.18
	rust-crates/thiserror-impl-2.0.18
	rust-crates/tinyvec-1.10.0
	rust-crates/tinyvec_macros-0.1.1
	rust-crates/typenum-1.19.0
	rust-crates/unicode-ident-1.0.22
	rust-crates/unicode-normalization-0.1.25
	rust-crates/unicode-width-0.2.2
	rust-crates/unicode_names2-1.3.0
	rust-crates/unicode_names2_generator-1.3.0
	rust-crates/version_check-0.9.5
	rust-crates/wasi-0.11.1+wasi-snapshot-preview1
	rust-crates/zerocopy-0.8.33
	rust-crates/zerocopy-derive-0.8.33
"
# lockstep-cargo-deps: end
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1

DESCRIPTION="Python bindings for mypy AST serialization"
HOMEPAGE="https://github.com/mypyc/ast_serialize"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a9/9d/912fefab0e30aee6a3af8a62bbea4a81b29afa4ba2c973d31170620a26de/ast_serialize-0.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ast_serialize-0.3.0"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
