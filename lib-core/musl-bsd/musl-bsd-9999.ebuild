# Distributed under the terms of the GNU General Public License v2

inherit meson git-r3 qa-policy

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
EGIT_REPO_URI="https://github.com/jopamo/musl-bsd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="!lib-core/glibc"
BDEPEND="virtual/pkgconfig"

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
	local host_runtime="/usr/lib/libmusl-bsd-glibc-host.so.2"
	local pc_dir="/usr/lib/pkgconfig"

	[[ -f "${ED}${core_archive}" ]] ||
		die "missing link-safe musl-bsd archive: ${core_archive}"
	[[ -f "${ED}${pc_dir}/musl-bsd-headers.pc" ]] ||
		die "missing musl-bsd headers interface"
	[[ -f "${ED}${pc_dir}/musl-bsd-source.pc" ]] ||
		die "missing musl-bsd source interface"
	grep -Fq 'Cflags: -I${overlayincludedir}' \
		"${ED}${pc_dir}/musl-bsd-headers.pc" ||
		die "invalid musl-bsd headers interface"
	grep -Fq 'Requires: musl-bsd-headers' \
		"${ED}${pc_dir}/musl-bsd-source.pc" ||
		die "musl-bsd source interface does not require its headers"
	grep -Fq 'Libs: -L${libdir}/musl-bsd -l:libmusl-bsd-core.a' \
		"${ED}${pc_dir}/musl-bsd-source.pc" ||
		die "musl-bsd source interface does not select the exact archive"
	[[ ! -e "${ED}/usr/lib/libmusl-bsd-glibc-host.so" ]] ||
		die "unversioned musl-bsd host linker name must not be installed"

	if use amd64; then
		[[ -e "${ED}${host_runtime}" ]] ||
			die "missing qualified musl-bsd runtime: ${host_runtime}"
		[[ -f "${ED}${pc_dir}/musl-bsd-glibc-host.pc" ]] ||
			die "missing qualified musl-bsd host interface"
		grep -Fq 'Libs: -L${libdir} -Wl,--push-state,--no-as-needed -l:libmusl-bsd-glibc-host.so.2 -Wl,--pop-state' \
			"${ED}${pc_dir}/musl-bsd-glibc-host.pc" ||
			die "invalid qualified musl-bsd host interface"

		local host_soname
		host_soname=$(
			"$(tc-getREADELF)" -d "${ED}${host_runtime}" |
				sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p'
		) || die "failed to inspect musl-bsd runtime SONAME"
		[[ ${host_soname} == libmusl-bsd-glibc-host.so.2 ]] ||
			die "invalid musl-bsd runtime SONAME: ${host_soname:-missing}"
	else
		[[ ! -e "${ED}${host_runtime}" ]] ||
			die "unqualified ABI installed musl-bsd host runtime"
		[[ ! -e "${ED}${pc_dir}/musl-bsd-glibc-host.pc" ]] ||
			die "unqualified ABI installed musl-bsd host interface"
	fi

	qa-policy-install
}
