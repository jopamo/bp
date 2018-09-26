# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src_all.tar.bz2"
LICENSE="LGPL-2.1 nonfree? ( unRAR )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="abi_x86_x32 doc kde +pch nonfree static"

DEPEND="${RDEPEND}
	abi_x86_x32? ( >=dev-lang/yasm-1.2.0-r1 )
	amd64? ( dev-lang/yasm )
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${PN}_${PV}

src_prepare() {
	default

	if ! use pch; then
		sed "s:PRE_COMPILED_HEADER=StdAfx.h.gch:PRE_COMPILED_HEADER=:g" -i makefile.* || die
	fi

	sed \
		-e 's:-m32 ::g' \
		-e 's:-m64 ::g' \
		-e 's:-pipe::g' \
		-e '/ALLFLAGS/s:-s ::' \
		-e "/OPTFLAGS=/s:=.*:=${CXXFLAGS}:" \
		-i makefile* || die

	# remove non-free RAR codec
	if use nonfree; then
		ewarn "Enabling nonfree RAR decompressor"
	else
		sed \
			-e '/Rar/d' \
			-e '/RAR/d' \
			-i makefile* CPP/7zip/Bundles/Format7zFree/makefile || die
		rm -rf CPP/7zip/Compress/Rar || die
	fi

	if use abi_x86_x32; then
		sed -i -e "/^ASM=/s:amd64:x32:" makefile* || die
		cp -f makefile.linux_amd64_asm makefile.machine || die
	elif use amd64; then
		cp -f makefile.linux_amd64_asm makefile.machine || die
	elif use x86; then
		cp -f makefile.linux_x86_asm_gcc_4.X makefile.machine || die
	elif use x86-fbsd; then
		# FreeBSD needs this special makefile, because it hasn't -ldl
		sed -e 's/-lc_r/-pthread/' makefile.freebsd > makefile.machine
	fi

	if use static; then
		sed -i -e '/^LOCAL_LIBS=/s/LOCAL_LIBS=/&-static /' makefile.machine || die
	fi
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) all3
}

src_test() {
	emake test test_7z test_7zr
}

src_install() {
	exeinto /usr/$(get_libdir)/${PN}
	doexe bin/7z bin/7za bin/7zr bin/7zCon.sfx
	doexe bin/*$(get_modname)
	if use nonfree; then
		exeinto /usr/$(get_libdir)/${PN}/Codecs/
		doexe bin/Codecs/*$(get_modname)
	fi

	if use doc; then
		doman man1/7z.1 man1/7za.1 man1/7zr.1
		dodoc DOC/*.txt
		dohtml -r DOC/MANUAL/*
	fi
}
