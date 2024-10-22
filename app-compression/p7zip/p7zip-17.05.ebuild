# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="https://github.com/p7zip-project/p7zip/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1 unRAR"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-lang/yasm"

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
	sed -i '/gzip/d' install.sh

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
