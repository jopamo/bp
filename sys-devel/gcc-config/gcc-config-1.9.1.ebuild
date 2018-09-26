# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Utility to manage compilers"
HOMEPAGE="https://gitweb.gentoo.org/proj/gcc-config.git/"
LICENSE="GPL-2"
SLOT="0"
SRC_URI="mirror://gentoo/${P}.tar.xz"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=sys-app/gentoo-functions-0.10"

src_compile() {
	emake CC="$(tc-getCC)" \
		PV="${PV}" \
		SUBLIBDIR="$(get_libdir)"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PV="${PV}" \
		SUBLIBDIR="$(get_libdir)" \
		install
}

pkg_postinst() {
	# Scrub eselect-compiler remains
	rm -f "${ROOT}"/etc/env.d/05compiler &

	# We not longer use the /usr/include/g++-v3 hacks, as
	# it is not needed ...
	rm -f "${ROOT}"/usr/include/g++{,-v3} &

	# Do we have a valid multi ver setup ?
	local x
	for x in $(gcc-config -C -l 2>/dev/null | awk '$NF == "*" { print $2 }') ; do
		gcc-config ${x}
	done

	wait
}
