# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=7156420fab0ff1589503ee7ec54de0be217b557e

inherit flag-o-matic toolchain-funcs python-any-r1

DESCRIPTION="GNU utilities for finding files"
HOMEPAGE="https://www.gnu.org/software/findutils/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/findutils"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/findutils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="test? ( ${PYTHON_DEPS} )"

BDEPEND="app-build/bison"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	sed -i \
		'/include.*config.h/a#ifdef MAJOR_IN_SYSMACROS\n#include <sys/sysmacros.h>\n#endif\n' \
		gl/lib/mountlist.c || die
}

src_configure() {
	use static && append-ldflags -static

	econf --disable-nls
}

src_compile() {
	emake -C locate dblocation.texi
	default
}

src_install() {
	default
	rm -rf "${ED}"/var/lib
}
