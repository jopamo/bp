# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Systems programming language from Mozilla"
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
IUSE="clippy musl rls rustfmt"

# Adjusting paths from opt to usr
QA_PREBUILT="
	usr/bin/.*
	usr/lib/.*.so
	usr/libexec/.*
	usr/lib/rustlib/.*/bin/.*
	usr/lib/rustlib/.*/lib/.*
"

RESTRICT="strip"
QA_EXECSTACK="usr/lib/rustlib/*/lib*.rlib:lib.rmeta"

# Function to determine the correct Rust target triple
get_rust_triple() {
	if use amd64; then
		if use musl; then
			echo "x86_64-unknown-linux-musl"
		else
			echo "x86_64-unknown-linux-gnu"
		fi
	elif use arm64; then
		if use musl; then
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
		--prefix="${ED}/usr" \
		--disable-ldconfig \
		|| die

	# Update the environment file with correct paths
	local rust_triple=$(get_rust_triple)

	cat <<-_EOF_ > "${T}/50${P}"
	LDPATH="${EPREFIX}/usr/lib/rustlib/${rust_triple}/lib"
	MANPATH="${EPREFIX}/usr/share/man"
	$(use amd64 && usex musl 'CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	$(use arm64 && usex musl 'CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	_EOF_
	doenvd "${T}/50${P}"

	# Fix installation path issues for certain binaries
	rm -f "${ED}/usr/lib/rustlib/${rust_triple}/bin/rust-llvm-dwp" || die
}
