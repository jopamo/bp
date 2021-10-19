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

DEPEND="dev-lang/perl"

S="${WORKDIR}/linux-headers-${PV}"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	default
	use musl && sed -i 's/compiler.h/stddef.h/g' include/uapi/linux/swab.h
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

src_test() {
	# Make sure no uapi/ include paths are used by accident.
	egrep -r \
		-e '# *include.*["<]uapi/' \
		"${D}" && die "#include uapi/xxx detected"

	einfo "Possible unescaped attribute/type usage"
	egrep -r \
		-e '(^|[[:space:](])(asm|volatile|inline)[[:space:](]' \
		-e '\<([us](8|16|32|64))\>' \
		.

	einfo "Missing linux/types.h include"
	egrep -l -r -e '__[us](8|16|32|64)' "${ED}" | xargs grep -L linux/types.h

	emake ARCH=$(tc-arch-kernel) headers_check
}
