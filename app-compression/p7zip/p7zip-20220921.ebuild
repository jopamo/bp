# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jinfeihan57/p7zip.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=aadc54316e85270c64f9ae18be5b032890781caa
	SRC_URI="https://github.com/jinfeihan57/p7zip/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1 unRAR"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-lang/yasm"

PATCHES=( "${FILESDIR}"/01-makefile.patch )

_makeargs=(
  prefix="${EPREFIX}"/usr
  LDFLAGS="${LDFLAGS}"
  DESTDIR="${D}"
  DEST_DIR="${ED}"
  DEST_HOME="${EPREFIX}"/usr
  DEST_MAN="${EPREFIX}"/usr/share/man
  CC=$(tc-getCC)
  CXX=$(tc-getCXX)
)

src_prepare() {
	filter-flags -Wl,-z,defs
	append-flags -Wno-narrowing

	default

	sed "s:PRE_COMPILED_HEADER=StdAfx.h.gch:PRE_COMPILED_HEADER=:g" -i makefile.* || die

	sed \
		-e 's:-m32 ::g' \
		-e 's:-m64 ::g' \
		-e 's:-pipe::g' \
		-e '/ALLFLAGS/s:-s ::' \
		-e "/OPTFLAGS=/s:=.*:=${CXXFLAGS}:" \
		-i makefile* || die

	cp -f makefile.linux_amd64_asm makefile.machine || die

	if use static; then
		sed -i -e '/^LOCAL_LIBS=/s/LOCAL_LIBS=/&-static /' makefile.machine || die
	fi

	sed -i '/gzip\ \-n/d' install.sh || die
	sed -i '/strip/d' install.sh || die
}

src_compile() {
	emake "${_makeargs[@]}" all3
}

src_test() {
	emake "${_makeargs[@]}" test test_7z test_7zr
}

src_install() {
	emake "${_makeargs[@]}" install

	cleanup_install
}
