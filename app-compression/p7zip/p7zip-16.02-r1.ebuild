# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src_all.tar.bz2"

LICENSE="LGPL-2.1 unRAR"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="dev-lang/yasm"

S=${WORKDIR}/${PN}_${PV}

PATCHES=(
		"${FILESDIR}"/01-makefile.patch
		"${FILESDIR}"/05-hardening-flags.patch
		"${FILESDIR}"/12-CVE-2016-9296.patch
		"${FILESDIR}"/13-CVE-2017-17969.patch
		"${FILESDIR}"/CVE-2018-5996.patch
		"${FILESDIR}"/CVE-2018-10115.patch
	)

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

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
