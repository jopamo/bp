# Distributed under the terms of the GNU General Public License v2
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/aho-corasick-1.1.5
	rust-crates/anstream-1.0.0
	rust-crates/anstyle-1.0.14
	rust-crates/anstyle-parse-1.0.0
	rust-crates/anstyle-query-1.1.5
	rust-crates/anstyle-wincon-3.0.11
	rust-crates/anyhow-1.0.104
	rust-crates/argmax-0.4.0
	rust-crates/bitflags-1.3.2
	rust-crates/bitflags-2.13.2
	rust-crates/block2-0.6.2
	rust-crates/bstr-1.13.1
	rust-crates/cc-1.10.0
	rust-crates/cfg-if-1.0.5
	rust-crates/cfg_aliases-0.2.2
	rust-crates/clap-4.6.7
	rust-crates/clap_builder-4.6.7
	rust-crates/clap_complete-4.6.11
	rust-crates/clap_derive-4.6.7
	rust-crates/clap_lex-1.1.1
	rust-crates/colorchoice-1.0.5
	rust-crates/crossbeam-channel-0.5.17
	rust-crates/crossbeam-deque-0.8.8
	rust-crates/crossbeam-epoch-0.9.21
	rust-crates/crossbeam-utils-0.8.23
	rust-crates/ctrlc-3.5.2
	rust-crates/defmt-1.2.0
	rust-crates/defmt-macros-1.2.0
	rust-crates/defmt-parser-1.1.0
	rust-crates/diff-0.1.13
	rust-crates/dispatch2-0.3.1
	rust-crates/errno-0.3.14
	rust-crates/etcetera-0.11.0
	rust-crates/faccess-0.2.4
	rust-crates/fastrand-2.5.0
	rust-crates/filetime-0.2.29
	rust-crates/find-msvc-tools-0.1.15
	rust-crates/getrandom-0.4.3
	rust-crates/globset-0.4.21
	rust-crates/heck-0.5.0
	rust-crates/ignore-0.4.34
	rust-crates/is_terminal_polyfill-1.70.2
	rust-crates/jiff-0.2.38
	rust-crates/jiff-core-0.1.1
	rust-crates/jiff-static-0.2.38
	rust-crates/jiff-tzdb-0.1.9
	rust-crates/jiff-tzdb-platform-0.1.3
	rust-crates/libc-0.2.191
	rust-crates/linux-raw-sys-0.12.1
	rust-crates/log-0.4.34
	rust-crates/lscolors-0.21.0
	rust-crates/memchr-2.8.3
	rust-crates/nix-0.30.1
	rust-crates/nix-0.31.3
	rust-crates/normpath-1.5.2
	rust-crates/nu-ansi-term-0.50.3
	rust-crates/objc2-0.6.5
	rust-crates/objc2-encode-4.1.0
	rust-crates/once_cell-1.21.4
	rust-crates/once_cell_polyfill-1.70.2
	rust-crates/portable-atomic-1.15.0
	rust-crates/portable-atomic-util-0.2.8
	rust-crates/proc-macro2-1.0.107
	rust-crates/quote-1.0.47
	rust-crates/r-efi-6.0.0
	rust-crates/regex-1.13.1
	rust-crates/regex-automata-0.4.18
	rust-crates/regex-syntax-0.8.11
	rust-crates/rustix-1.1.6
	rust-crates/same-file-1.0.6
	rust-crates/serde_core-1.0.229
	rust-crates/serde_derive-1.0.229
	rust-crates/shlex-2.0.1
	rust-crates/strsim-0.11.1
	rust-crates/syn-2.0.119
	rust-crates/syn-3.0.9
	rust-crates/tempfile-3.27.0
	rust-crates/terminal_size-0.4.4
	rust-crates/test-case-3.4.0
	rust-crates/test-case-core-3.4.0
	rust-crates/test-case-macros-3.4.0
	rust-crates/thiserror-2.0.21
	rust-crates/thiserror-impl-2.0.21
	rust-crates/tikv-jemalloc-sys-0.7.1+5.3.1-0-g81034ce1f1373e37dc865038e1bc8eeecf559ce8
	rust-crates/tikv-jemallocator-0.7.0
	rust-crates/unicode-ident-1.0.27
	rust-crates/utf8parse-0.2.2
	rust-crates/walkdir-2.5.0
	rust-crates/winapi-0.3.9
	rust-crates/winapi-i686-pc-windows-gnu-0.4.0
	rust-crates/winapi-util-0.1.11
	rust-crates/winapi-x86_64-pc-windows-gnu-0.4.0
	rust-crates/windows-link-0.2.1
	rust-crates/windows-sys-0.61.2
"
# lockstep-cargo-deps: end
inherit cargo lockstep-cargo

DESCRIPTION="A simple, fast and user-friendly alternative to gnu find"
HOMEPAGE="https://github.com/sharkdp/fd"
SNAPSHOT=6cf330283cfdcd1b8a6100beec7375bbb58975a3
SRC_URI="https://github.com/sharkdp/fd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	dobin target/release/"${PN}"
}
