# Distributed under the terms of the GNU General Public License v2

EAPI=8

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"

inherit kernel-2

detect_version

DESCRIPTION="Linux kernel headers compiled from latest lts linux kernel sources"
HOMEPAGE="https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="musl"

DEPEND="app-lang/perl"

S="${WORKDIR}/linux-headers-${PV}"

src_unpack() {
	unpack ${A}
}

src_test() {
	emake headers_check ${xmakeopts}
}

src_install() {
	kernel-2_src_install

	if use musl ; then
		rm "${ED}"/usr/include/linux/sysinfo.h
		dosym -r /usr/include/sys/sysinfo.h /usr/include/linux/sysinfo.h
	fi

	# hrm, build system sucks
	find "${ED}" '(' -name '.install' -o -name '*.cmd' ')' -delete
	find "${ED}" -depth -type d -delete 2>/dev/null
}
