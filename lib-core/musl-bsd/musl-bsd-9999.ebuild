# Distributed under the terms of the GNU General Public License v2

inherit meson git-r3 qa-policy

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
EGIT_REPO_URI="https://github.com/jopamo/musl-bsd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="!lib-core/glibc"

src_configure() {
	local emesonargs=(
		-Db_staticpic=true
	)

	if use amd64; then
		emesonargs+=( -Dglibc_runtime=enabled )
	elif use arm64; then
		emesonargs+=( -Dglibc_runtime=disabled )
	else
		die "unsupported architecture for musl-bsd runtime policy"
	fi

	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install

	local core_dir="/usr/lib/musl-bsd"
	local core_archive="${core_dir}/libmusl-bsd-core.a"
	local core_runtime="${core_dir}/libmusl-bsd-core.so.2"

	[[ -f "${ED}${core_archive}" ]] ||
		die "missing link-safe musl-bsd archive: ${core_archive}"

	if use amd64; then
		[[ -e "${ED}${core_runtime}" ]] ||
			die "missing qualified musl-bsd runtime: ${core_runtime}"

		local core_soname
		core_soname=$(
			"$(tc-getREADELF)" -d "${ED}${core_runtime}" |
				sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p'
		) || die "failed to inspect musl-bsd runtime SONAME"
		[[ ${core_soname} == libmusl-bsd-core.so.2 ]] ||
			die "invalid musl-bsd runtime SONAME: ${core_soname:-missing}"

		# Runtime discovery exposes only the versioned SONAME. The development
		# linker name and archive remain private to the compiler driver's exact
		# sysroot-relative paths.
		dosym -r "${core_runtime}" /usr/lib/libmusl-bsd-core.so.2
	fi

	qa-policy-install
}
