# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"
SNAPSHOT=b86f0198d6879cb63485b14c050925e34b6549d0
SRC_URI="https://github.com/1g4-mirror/busybox/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minimal"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

install_busybox_symlinks() {
	local bb_bin=${ED%/}/usr/bin/busybox
	local root_prefix=${ROOT:-/}
	local cmd_name
	local existing_cmd_path

	[[ -x ${bb_bin} ]] || die "busybox binary missing from install image: ${bb_bin}"

	while IFS= read -r cmd_name; do
		[[ ${cmd_name} == busybox ]] && continue
		existing_cmd_path=${root_prefix%/}/usr/bin/${cmd_name}
		[[ -e ${existing_cmd_path} || -L ${existing_cmd_path} ]] && continue
		dosym busybox "/usr/bin/${cmd_name}"
	done < <("${bb_bin}" --list)
}

src_prepare() {
	default

	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	qa-policy-configure
	filter-flags -flto*
	append-ldflags -static -no-pie -fno-PIE
	append-ldflags -Wl,-z,noexecstack
	emake CC=musl-gcc
}

src_install() {
	dobin busybox
	doman docs/busybox.1
	install_busybox_symlinks
	qa-policy-install
}
