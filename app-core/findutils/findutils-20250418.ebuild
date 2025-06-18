# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs python-any-r1

DESCRIPTION="GNU utilities for finding files"
HOMEPAGE="https://www.gnu.org/software/findutils/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static test"

DEPEND="test? ( ${PYTHON_DEPS} )"

BDEPEND="app-build/bison"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	default
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	sed -i \
		'/include.*config.h/a#ifdef MAJOR_IN_SYSMACROS\n#include <sys/sysmacros.h>\n#endif\n' \
		gl/lib/mountlist.c || die

	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	use static && append-ldflags -static

	econf $(use_enable nls)
}

src_compile() {
	emake -C locate dblocation.texi
	default
}

src_install() {
	default
	rm -rf "${ED}"/var/lib
}
