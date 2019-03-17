# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

BASEVERSION="4.6.0"
MY_P="findutils-${BASEVERSION}"

inherit flag-o-matic toolchain-funcs python-any-r1

DESCRIPTION="GNU utilities for finding files"
HOMEPAGE="https://www.gnu.org/software/findutils/"

SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz
		https://1g4.org/files/findutils-20180716.patch.tar.xz"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+"
SLOT="0"
IUSE="nls static test"

DEPEND="test? ( ${PYTHON_DEPS} )"

PATCHES=(
		"${WORKDIR}"/findutils-20180716.patch
	)

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	default
	sed -i.bak -e "s/UNKNOWN/${PV}/g" "build-aux/git-version-gen"
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	sed -i \
		'/include.*config.h/a#ifdef MAJOR_IN_SYSMACROS\n#include <sys/sysmacros.h>\n#endif\n' \
		gl/lib/mountlist.c || die

	chmod 700 build-aux/git-version-gen
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
