# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="https://www.gnu.org/software/gperf/"
SRC_URI="mirror://gnu/gperf/${P}.tar.gz
		https://1g4.org/files/gperf-20180909.patch.tar.xz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

PATCHES=(
		"${WORKDIR}/gperf-patch-20180909.patch"
	)
src_prepare() {
	sed -i \
		-e "/^CPPFLAGS /s:=:+=:" \
		*/Makefile.in || die #444078

	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	econf ${myconf[@]}
}
