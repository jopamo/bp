# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/autocfg-1.3.0
	rust-crates/bitflags-1.3.2
	rust-crates/bitflags-2.7.0
	rust-crates/cc-1.0.96
	rust-crates/cfg-if-1.0.0
	rust-crates/crossbeam-channel-0.5.15
	rust-crates/crossbeam-utils-0.8.19
	rust-crates/filetime-0.2.24
	rust-crates/fsevent-sys-4.1.0
	rust-crates/heck-0.5.0
	rust-crates/indoc-2.0.5
	rust-crates/inotify-0.11.0
	rust-crates/inotify-sys-0.1.5
	rust-crates/kqueue-1.0.8
	rust-crates/kqueue-sys-1.0.4
	rust-crates/libc-0.2.169
	rust-crates/libredox-0.1.3
	rust-crates/log-0.4.22
	rust-crates/memoffset-0.9.1
	rust-crates/mio-1.0.3
	rust-crates/notify-8.0.0
	rust-crates/notify-types-2.0.0
	rust-crates/once_cell-1.21.3
	rust-crates/portable-atomic-1.6.0
	rust-crates/proc-macro2-1.0.81
	rust-crates/pyo3-0.26.0
	rust-crates/pyo3-build-config-0.26.0
	rust-crates/pyo3-ffi-0.26.0
	rust-crates/pyo3-macros-0.26.0
	rust-crates/pyo3-macros-backend-0.26.0
	rust-crates/python3-dll-a-0.2.14
	rust-crates/quote-1.0.36
	rust-crates/redox_syscall-0.5.3
	rust-crates/same-file-1.0.6
	rust-crates/syn-2.0.60
	rust-crates/target-lexicon-0.13.2
	rust-crates/unicode-ident-1.0.12
	rust-crates/unindent-0.2.3
	rust-crates/walkdir-2.5.0
	rust-crates/wasi-0.11.0+wasi-snapshot-preview1
	rust-crates/winapi-util-0.1.9
	rust-crates/windows-sys-0.52.0
	rust-crates/windows-sys-0.59.0
	rust-crates/windows-targets-0.52.6
	rust-crates/windows_aarch64_gnullvm-0.52.6
	rust-crates/windows_aarch64_msvc-0.52.6
	rust-crates/windows_i686_gnu-0.52.6
	rust-crates/windows_i686_gnullvm-0.52.6
	rust-crates/windows_i686_msvc-0.52.6
	rust-crates/windows_x86_64_gnu-0.52.6
	rust-crates/windows_x86_64_gnullvm-0.52.6
	rust-crates/windows_x86_64_msvc-0.52.6
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="watchfiles"
DESCRIPTION="Simple, modern and high performance file watching and code reload in python."
HOMEPAGE="https://github.com/samuelcolvin/watchfiles"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
"
# lockstep-pypi-deps: end
