# Distributed under the terms of the GNU General Public License v2
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/aho-corasick-1.1.3
	rust-crates/anyhow-1.0.100
	rust-crates/arbitrary-1.4.2
	rust-crates/bstr-1.12.0
	rust-crates/cc-1.2.41
	rust-crates/cfg-if-1.0.4
	rust-crates/crossbeam-channel-0.5.15
	rust-crates/crossbeam-deque-0.8.6
	rust-crates/crossbeam-epoch-0.9.18
	rust-crates/crossbeam-utils-0.8.21
	rust-crates/derive_arbitrary-1.4.2
	rust-crates/encoding_rs-0.8.35
	rust-crates/encoding_rs_io-0.1.7
	rust-crates/find-msvc-tools-0.1.4
	rust-crates/getrandom-0.3.4
	rust-crates/glob-0.3.3
	rust-crates/itoa-1.0.15
	rust-crates/jobserver-0.1.34
	rust-crates/lexopt-0.3.1
	rust-crates/libc-0.2.177
	rust-crates/log-0.4.28
	rust-crates/memchr-2.7.6
	rust-crates/memmap2-0.9.9
	rust-crates/pcre2-0.2.11
	rust-crates/pcre2-sys-0.2.10
	rust-crates/pkg-config-0.3.32
	rust-crates/proc-macro2-1.0.101
	rust-crates/quote-1.0.41
	rust-crates/r-efi-5.3.0
	rust-crates/regex-1.12.2
	rust-crates/regex-automata-0.4.13
	rust-crates/regex-syntax-0.8.8
	rust-crates/ryu-1.0.20
	rust-crates/same-file-1.0.6
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.145
	rust-crates/shlex-1.3.0
	rust-crates/syn-2.0.107
	rust-crates/termcolor-1.4.1
	rust-crates/textwrap-0.16.2
	rust-crates/tikv-jemalloc-sys-0.6.1+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7
	rust-crates/tikv-jemallocator-0.6.1
	rust-crates/unicode-ident-1.0.20
	rust-crates/walkdir-2.5.0
	rust-crates/wasip2-1.0.1+wasi-0.2.4
	rust-crates/winapi-util-0.1.11
	rust-crates/windows-link-0.2.1
	rust-crates/windows-sys-0.61.2
	rust-crates/wit-bindgen-0.46.0
"
# lockstep-cargo-deps: end
inherit cargo lockstep-cargo

DESCRIPTION="ripgrep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SNAPSHOT=4519153e5e461527f4bca45b042fff45c4ec6fb9
SRC_URI="https://github.com/BurntSushi/ripgrep/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	cargo build --release --features 'pcre2'
}

src_install() {
	dobin target/release/rg
}
