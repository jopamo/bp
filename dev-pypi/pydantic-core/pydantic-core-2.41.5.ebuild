# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/ahash-0.8.12
	rust-crates/aho-corasick-1.1.3
	rust-crates/autocfg-1.3.0
	rust-crates/base64-0.22.1
	rust-crates/bitflags-2.9.1
	rust-crates/bitvec-1.0.1
	rust-crates/bumpalo-3.19.0
	rust-crates/cc-1.0.101
	rust-crates/cfg-if-1.0.0
	rust-crates/displaydoc-0.2.5
	rust-crates/enum_dispatch-0.3.13
	rust-crates/form_urlencoded-1.2.1
	rust-crates/funty-2.0.0
	rust-crates/getrandom-0.3.3
	rust-crates/heck-0.5.0
	rust-crates/hex-0.4.3
	rust-crates/icu_collections-1.5.0
	rust-crates/icu_locid-1.5.0
	rust-crates/icu_locid_transform-1.5.0
	rust-crates/icu_locid_transform_data-1.5.0
	rust-crates/icu_normalizer-1.5.0
	rust-crates/icu_normalizer_data-1.5.0
	rust-crates/icu_properties-1.5.1
	rust-crates/icu_properties_data-1.5.0
	rust-crates/icu_provider-1.5.0
	rust-crates/icu_provider_macros-1.5.0
	rust-crates/idna-1.1.0
	rust-crates/idna_adapter-1.2.0
	rust-crates/indoc-2.0.5
	rust-crates/itoa-1.0.11
	rust-crates/jiter-0.11.1
	rust-crates/js-sys-0.3.77
	rust-crates/lexical-parse-float-1.0.5
	rust-crates/lexical-parse-integer-1.0.5
	rust-crates/lexical-util-1.0.6
	rust-crates/libc-0.2.155
	rust-crates/litemap-0.7.3
	rust-crates/log-0.4.27
	rust-crates/memchr-2.7.4
	rust-crates/memoffset-0.9.1
	rust-crates/num-bigint-0.4.6
	rust-crates/num-integer-0.1.46
	rust-crates/num-traits-0.2.19
	rust-crates/once_cell-1.21.3
	rust-crates/percent-encoding-2.3.2
	rust-crates/portable-atomic-1.6.0
	rust-crates/proc-macro2-1.0.86
	rust-crates/pyo3-0.26.0
	rust-crates/pyo3-build-config-0.26.0
	rust-crates/pyo3-ffi-0.26.0
	rust-crates/pyo3-macros-0.26.0
	rust-crates/pyo3-macros-backend-0.26.0
	rust-crates/python3-dll-a-0.2.14
	rust-crates/quote-1.0.36
	rust-crates/r-efi-5.2.0
	rust-crates/radium-0.7.0
	rust-crates/regex-1.12.2
	rust-crates/regex-automata-0.4.13
	rust-crates/regex-syntax-0.8.5
	rust-crates/rustversion-1.0.17
	rust-crates/ryu-1.0.18
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.145
	rust-crates/smallvec-1.15.1
	rust-crates/speedate-0.17.0
	rust-crates/stable_deref_trait-1.2.0
	rust-crates/static_assertions-1.1.0
	rust-crates/strum-0.27.2
	rust-crates/strum_macros-0.27.2
	rust-crates/syn-2.0.82
	rust-crates/synstructure-0.13.1
	rust-crates/tap-1.0.1
	rust-crates/target-lexicon-0.13.2
	rust-crates/tinystr-0.7.6
	rust-crates/unicode-ident-1.0.12
	rust-crates/unindent-0.2.3
	rust-crates/url-2.5.4
	rust-crates/utf16_iter-1.0.5
	rust-crates/utf8_iter-1.0.4
	rust-crates/uuid-1.18.1
	rust-crates/version_check-0.9.5
	rust-crates/wasi-0.14.2+wasi-0.2.4
	rust-crates/wasm-bindgen-0.2.100
	rust-crates/wasm-bindgen-backend-0.2.100
	rust-crates/wasm-bindgen-macro-0.2.100
	rust-crates/wasm-bindgen-macro-support-0.2.100
	rust-crates/wasm-bindgen-shared-0.2.100
	rust-crates/wit-bindgen-rt-0.39.0
	rust-crates/write16-1.0.0
	rust-crates/writeable-0.5.5
	rust-crates/wyz-0.5.1
	rust-crates/yoke-0.7.4
	rust-crates/yoke-derive-0.7.4
	rust-crates/zerocopy-0.8.25
	rust-crates/zerocopy-derive-0.8.25
	rust-crates/zerofrom-0.1.4
	rust-crates/zerofrom-derive-0.1.4
	rust-crates/zerovec-0.10.4
	rust-crates/zerovec-derive-0.10.3
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="pydantic-core"
DESCRIPTION="Core functionality for Pydantic validation and serialization"
HOMEPAGE="https://github.com/pydantic/pydantic-core"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
