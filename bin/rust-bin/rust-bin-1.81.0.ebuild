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

RDEPEND="app-eselec/eselect-rust"

QA_PREBUILT="
	opt/${P}/bin/.*
	opt/${P}/lib/.*.so
	opt/${P}/libexec/.*
	opt/${P}/lib/rustlib/.*/bin/.*
	opt/${P}/lib/rustlib/.*/lib/.*
"

RESTRICT="strip"
QA_EXECSTACK="opt/${P}/lib/rustlib/*/lib*.rlib:lib.rmeta"

src_unpack() {
	default

	if use amd64; then
		if use musl; then
			mv "${WORKDIR}/rust-${PV}-x86_64-unknown-linux-musl" "${S}" || die
		else
			mv "${WORKDIR}/rust-${PV}-x86_64-unknown-linux-gnu" "${S}" || die
		fi
	fi
	if use arm64; then
		if use musl; then
			mv "${WORKDIR}/rust-${PV}-aarch64-unknown-linux-musl" "${S}" || die
		else
			mv "${WORKDIR}/rust-${PV}-aarch64-unknown-linux-gnu" "${S}" || die
		fi
	fi
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
		--prefix="${ED}/opt/${P}" \
		--mandir="${ED}/opt/${P}/man" \
		--disable-ldconfig \
		|| die

	local symlinks=(
		cargo
		rustc
		rustdoc
		rust-gdb
		rust-gdbgui
		rust-lldb
	)

	use clippy && symlinks+=( clippy-driver cargo-clippy )
	use rls && symlinks+=( rls )
	use rustfmt && symlinks+=( rustfmt cargo-fmt )

	einfo "installing eselect-rust symlinks and paths"
	local i
	for i in "${symlinks[@]}"; do
		# we need realpath on /usr/bin/* symlink return version-appended binary path.
		# so /usr/bin/rustc should point to /opt/rust-bin-<ver>/bin/rustc-<ver>
		local ver_i="${i}-bin-${PV}"
		ln -v "${ED}/opt/${P}/bin/${i}" "${ED}/opt/${P}/bin/${ver_i}"
		dosym "../../opt/${P}/bin/${ver_i}" "/usr/bin/${ver_i}"
	done

	# symlinks to switch components to active rust in eselect
	dosym "../../../opt/${P}/lib" "/usr/lib/rust/lib-bin-${PV}"
	dosym "../../../opt/${P}/man" "/usr/lib/rust/man-bin-${PV}"
	dosym "../../opt/${P}/lib/rustlib" "/usr/lib/rustlib-bin-${PV}"

	# musl logic can be improved a bit, but fine as is for now
	cat <<-_EOF_ > "${T}/50${P}"
	LDPATH="${EPREFIX}/usr/lib/rust/lib"
	MANPATH="${EPREFIX}/usr/lib/rust/man"
	$(use amd64 && usex musl 'CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	$(use arm64 && usex musl 'CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_RUSTFLAGS="-C target-feature=-crt-static"' '')
	_EOF_
	doenvd "${T}/50${P}"

	# note: eselect-rust adds EROOT to all paths below
	cat <<-_EOF_ > "${T}/provider-${P}"
	/usr/bin/cargo
	/usr/bin/rustdoc
	/usr/bin/rust-gdb
	/usr/bin/rust-gdbgui
	/usr/bin/rust-lldb
	/usr/lib/rustlib
	/usr/lib/rust/lib
	/usr/lib/rust/man
	_EOF_

	if use clippy; then
		echo /usr/bin/clippy-driver >> "${T}/provider-${P}"
		echo /usr/bin/cargo-clippy >> "${T}/provider-${P}"
	fi
	if use rls; then
		echo /usr/bin/rls >> "${T}/provider-${P}"
	fi
	if use rustfmt; then
		echo /usr/bin/rustfmt >> "${T}/provider-${P}"
		echo /usr/bin/cargo-fmt >> "${T}/provider-${P}"
	fi

	insinto /etc/env.d/rust
	doins "${T}/provider-${P}"
	popd >/dev/null || die

	# BUG: installs x86_64 binary on other arches
	rm -f "${ED}/opt/${P}/lib/rustlib/"*/bin/rust-llvm-dwp || die
}

pkg_postinst() {
	eselect rust update
}

pkg_postrm() {
	eselect rust cleanup
}
