# Distributed under the terms of the GNU General Public License v2



DESCRIPTION="Prebuilt Rust compiler and toolchain (systems programming language)"
HOMEPAGE="https://www.rust-lang.org/"
SRC_URI="
	amd64? (
		elibc_musl? ( https://static.rust-lang.org/dist/rust-${PV}-x86_64-unknown-linux-musl.tar.gz )
		!elibc_musl? ( https://static.rust-lang.org/dist/rust-${PV}-x86_64-unknown-linux-gnu.tar.gz )
	)
	arm64? (
		elibc_musl? ( https://static.rust-lang.org/dist/rust-${PV}-aarch64-unknown-linux-musl.tar.gz )
		!elibc_musl? ( https://static.rust-lang.org/dist/rust-${PV}-aarch64-unknown-linux-gnu.tar.gz )
	)
"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="clippy rls rustfmt"
RDEPEND="
	elibc_musl? ( app-build/llvm )
"

QA_PREBUILT="
	opt/bin/.*
	opt/lib/.*.so
	opt/libexec/.*
	opt/lib/rustlib/.*/bin/.*
	opt/lib/rustlib/.*/lib/.*
"

RESTRICT="strip"
QA_EXECSTACK="opt/lib/rustlib/*/lib*.rlib:lib.rmeta"

get_rust_triple() {
	if use amd64; then
		if use elibc_musl; then
			echo "x86_64-unknown-linux-musl"
		else
			echo "x86_64-unknown-linux-gnu"
		fi
	elif use arm64; then
		if use elibc_musl; then
			echo "aarch64-unknown-linux-musl"
		else
			echo "aarch64-unknown-linux-gnu"
		fi
	else
		die "Unsupported architecture"
	fi
}

src_unpack() {
	default

	local rust_triple=$(get_rust_triple)

	mv "${WORKDIR}/rust-${PV}-${rust_triple}" "${S}" || die
}

src_install() {
	pushd "${S}" >/dev/null || die
	local analysis std
	analysis="$(grep 'analysis' ./components)"
	std="$(grep 'std' ./components)"
	local components="rustc,cargo,${std}"
	use clippy && components="${components},clippy-preview"
	use rls && components="${components},rls-preview,${analysis}"
	use rustfmt && components="${components},rustfmt-preview"

	./install.sh \
		--components="${components}" \
		--disable-verify \
		--prefix="${ED}/opt" \
		--disable-ldconfig \
		|| die

	# Update the environment file with correct paths
	local rust_triple=$(get_rust_triple)

	cat <<-_EOF_ > "${T}/50${P}"
	LDPATH="${EPREFIX}/opt/lib/rustlib/${rust_triple}/lib"
	MANPATH="${EPREFIX}/opt/share/man"
	$(use amd64 && usex elibc_musl 'CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	$(use arm64 && usex elibc_musl 'CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	_EOF_
	doenvd "${T}/50${P}"

	if use elibc_musl; then
		# Upstream musl std falls back to -lgcc_s for proc-macro / dylib links
		# when crt-static is disabled. Point that lookup at the LLVM unwinder so
		# rust-bin can bootstrap source Rust on GCC-free musl systems.
		dosym -r /usr/lib/libunwind.so \
			/opt/lib/rustlib/${rust_triple}/lib/libgcc_s.so
		dosym -r /usr/lib/libunwind.so.1 \
			/opt/lib/rustlib/${rust_triple}/lib/libgcc_s.so.1
	fi

	# Fix installation path issues for certain binaries
	rm -f "${ED}/opt/lib/rustlib/${rust_triple}/bin/rust-llvm-dwp" || die
}
