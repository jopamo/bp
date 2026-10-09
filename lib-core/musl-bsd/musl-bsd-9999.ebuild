# Distributed under the terms of the GNU General Public License v2

inherit meson git-r3 qa-policy

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
EGIT_REPO_URI="https://github.com/jopamo/musl-bsd.git"

LICENSE="GPL-2 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="!lib-core/glibc"
BDEPEND="app-dev/pkgconf"

src_configure() {
	local emesonargs=(
		-Db_staticpic=true
		-Dglibc_runtime=disabled
	)

	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install

	local core_dir="/usr/lib/musl-bsd"
	local core_archive="${core_dir}/libmusl-bsd-core.a"
	local host_runtime="/usr/lib/libmusl-bsd-glibc-host.so.2"
	local pc_dir="/usr/lib/pkgconfig"
	local startup_pc="${pc_dir}/musl-bsd-glibc-startup.pc"

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

	[[ ! -e "${ED}${host_runtime}" ]] ||
		die "disabled musl-bsd host runtime was installed"
	[[ ! -e "${ED}${pc_dir}/musl-bsd-glibc-host.pc" ]] ||
		die "disabled musl-bsd host interface was installed"
	[[ ! -e "${ED}${startup_pc}" ]] ||
		die "disabled musl-bsd startup interface was installed"

	qa-policy-install
}
