# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multiprocessing python-any-r1 toolchain-funcs rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"
SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"
S="${WORKDIR}/rustc-${PV}-src"

LICENSE="MIT Apache-2.0"
SLOT="0"
#KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/llvm
	app-dev/cmake
"

ABI_VER="$(ver_cut 1-2)"

CMAKE_WARN_UNUSED_CLI=no

RESTRICT="test network-sandbox"

# ignore QA for rust sysroot artifacts
QA_FLAGS_IGNORED="
	usr/lib/${PN}/${PV}/bin/.*
	usr/libexec/.*
	usr/lib/lib.*.so
	usr/lib/rustlib/.*/bin/.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

QA_SONAME="
	usr/lib/lib/lib.*.so.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

QA_EXECSTACK="usr/lib/rustlib/*/lib*.rlib:lib.rmeta"

# resolve stage0 bin dir from PATH, fall back to /opt/bin for rust-bin
_stage0_bin() {
	local p
	p="$(type -P rustc 2>/dev/null || true)"
	if [[ -n "${p}" ]]; then
		dirname -- "${p}"
	elif [[ -x /opt/bin/rustc ]]; then
		echo /opt/bin
	else
		echo /usr/bin
	fi
}

# resolve rust host triple from stage0 rustc
_rust_host_triple() {
	"$(_stage0_bin)/rustc" -vV | sed -n 's/^host: //p'
}

# pick a C++ compiler that can find <cassert>, return the binary only
_pick_cxx_bin() {
	# prefer clang++ if it already sees libstdc++ headers
	if echo '#include <cassert>' | clang++ -E -x c++ - >/dev/null 2>&1; then
		echo clang++
		return
	fi
	# otherwise prefer g++ on musl
	if type -P g++ >/dev/null 2>&1; then
		echo g++
		return
	fi
	# last resort use clang++ and we will inject discovery flags via CXXFLAGS
	echo clang++
}

# compute extra flags for clang++ if it can't see libstdc++ by default
_clang_libstdcxx_fixflags() {
	if echo '#include <cassert>' | clang++ -E -x c++ - >/dev/null 2>&1; then
		echo ""
		return
	fi
	# try toolchain discovery
	if echo '#include <cassert>' | clang++ --gcc-toolchain=/usr -stdlib=libstdc++ -E -x c++ - >/dev/null 2>&1; then
		echo "--gcc-toolchain=/usr -stdlib=libstdc++"
		return
	fi
	# if you have libc++, uncomment the next line and ensure libcxx{,abi},unwind are installed
	# echo "-stdlib=libc++ -lc++abi -lunwind"
	echo ""
}

pkg_setup() {
	python-any-r1_pkg_setup

	# bootstrap crates should not try pkg-config for libgit2
	export LIBGIT2_NO_PKG_CONFIG=1

	# link against system-shared LLVM
	export LLVM_LINK_SHARED=1
	export RUSTFLAGS="${RUSTFLAGS} -Lnative=$("/usr/bin/llvm-config" --libdir)"
	export RUSTFLAGS="${RUSTFLAGS} -C link-arg=-lzstd"

	# tls roots for network-sandboxed fetches
	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
	filter-clang
	filter-lto
	default
}

src_configure() {
	local stage0_bin="$(_stage0_bin)"
	local stage0_cargo="${stage0_bin}/cargo"
	local stage0_rustc="${stage0_bin}/rustc"
	local rust_host="$(_rust_host_triple)"
	local libdir="lib"

	# write bootstrap config used by x.py
	cat > "${S}"/config.toml <<- _EOF_
		# keep x.py from nagging about config review
		change-id = 142379

		[build]
		cargo = "${stage0_cargo}"
		rustc = "${stage0_rustc}"
		python = "${EPYTHON}"
		docs = false
		compiler-docs = false
		vendor = true
		sanitizers = false
		tools = ["cargo","clippy","src"]
		host = ["${rust_host}"]
		target = ["${rust_host}"]

		[install]
		prefix = "${EPREFIX}/usr"
		sysconfdir = "${EPREFIX}/etc"
		docdir = "share/doc/rust"
		bindir = "bin"
		libdir = "${libdir}"
		mandir = "share/man"

		[rust]
		optimize = false
		rpath = false
		download-rustc = false

		[target.${rust_host}]
		llvm-config = "/usr/bin/llvm-config"
	_EOF_
}

src_compile() {
	export PKG_CONFIG_ALLOW_CROSS=1
	(
		IFS=$'\n'
		RUST_BACKTRACE=1 "${EPYTHON}" ./x.py build -vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)
}

src_install() {
	(
		IFS=$'\n'
		DESTDIR="${D}" "${EPYTHON}" ./x.py install -vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)

	# verify std landed under the host triple rust expects
	local rust_host="$(_rust_host_triple)"
	[[ -d "${ED}/usr/lib/rustlib/${rust_host}/lib" ]] || die "missing rustlib for ${rust_host} under /usr/lib/rustlib"

	cleanup_install
	dedup_symlink "${ED}"
}
