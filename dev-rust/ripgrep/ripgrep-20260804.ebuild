# Distributed under the terms of the GNU General Public License v2
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/aho-corasick-1.1.5
	rust-crates/anyhow-1.0.104
	rust-crates/arbitrary-1.4.2
	rust-crates/bstr-1.13.0
	rust-crates/cc-1.4.0
	rust-crates/cfg-if-1.0.4
	rust-crates/crossbeam-channel-0.5.16
	rust-crates/crossbeam-deque-0.8.7
	rust-crates/crossbeam-epoch-0.9.20
	rust-crates/crossbeam-utils-0.8.22
	rust-crates/derive_arbitrary-1.4.2
	rust-crates/encoding_rs-0.8.35
	rust-crates/encoding_rs_io-0.1.8
	rust-crates/find-msvc-tools-0.1.9
	rust-crates/fst-0.4.7
	rust-crates/getrandom-0.4.3
	rust-crates/glob-0.3.4
	rust-crates/itoa-1.0.18
	rust-crates/jobserver-0.1.35
	rust-crates/lexopt-0.3.2
	rust-crates/libc-0.2.189
	rust-crates/log-0.4.33
	rust-crates/memchr-2.8.3
	rust-crates/memmap2-0.9.11
	rust-crates/pcre2-0.2.11
	rust-crates/pcre2-sys-0.2.10
	rust-crates/pkg-config-0.3.33
	rust-crates/proc-macro2-1.0.107
	rust-crates/quote-1.0.47
	rust-crates/r-efi-6.0.0
	rust-crates/redb-4.1.0
	rust-crates/regex-1.13.1
	rust-crates/regex-automata-0.4.18
	rust-crates/regex-syntax-0.8.11
	rust-crates/same-file-1.0.6
	rust-crates/serde-1.0.229
	rust-crates/serde_core-1.0.229
	rust-crates/serde_derive-1.0.229
	rust-crates/serde_json-1.0.151
	rust-crates/shlex-2.0.1
	rust-crates/syn-2.0.119
	rust-crates/syn-3.0.3
	rust-crates/termcolor-1.4.1
	rust-crates/textwrap-0.16.2
	rust-crates/tikv-jemalloc-sys-0.7.1+5.3.1-0-g81034ce1f1373e37dc865038e1bc8eeecf559ce8
	rust-crates/tikv-jemallocator-0.7.0
	rust-crates/unicode-ident-1.0.24
	rust-crates/walkdir-2.5.0
	rust-crates/winapi-util-0.1.11
	rust-crates/windows-link-0.2.1
	rust-crates/windows-sys-0.61.2
	rust-crates/zmij-1.0.23
"
# lockstep-cargo-deps: end
inherit cargo lockstep-cargo

DESCRIPTION="ripgrep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SNAPSHOT=3fce3b5bb0236da2df6d99672afb8a719642eca7
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
