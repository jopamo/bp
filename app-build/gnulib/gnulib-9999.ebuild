# Distributed under the terms of the GNU General Public License v2

GNULIB_SNAPSHOT=ac19d2a1ff86dfb70bec3fd1dc6e2fa10b35439e

DESCRIPTION="GNU portability library for reusable code"
HOMEPAGE="https://savannah.gnu.org/projects/gnulib"
SRC_URI="https://github.com/coreutils/gnulib/archive/${GNULIB_SNAPSHOT}.tar.gz -> ${PN}-${GNULIB_SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${GNULIB_SNAPSHOT}"

LICENSE="GPL-3+ LGPL-2.1+ FDL-1.3+"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_compile() { :; }

src_install() {
	mkdir -p "${ED}"/usr/share || die
	cp -a "${S}" "${ED}"/usr/share/gnulib || die
	rm -rf "${ED}"/usr/share/gnulib/.git \
		"${ED}"/usr/share/gnulib/.gitmodules \
		"${ED}"/usr/share/gnulib/.gitignore || die
	dosym ../share/gnulib/gnulib-tool /usr/bin/gnulib-tool
}
