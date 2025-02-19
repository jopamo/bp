# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="GUID disk partition editor"
HOMEPAGE="https://github.com/caldwell/gdisk"

SNAPSHOT=28a3e372e3802ef32cd594bdb7825de04f0ca955
SRC_URI="https://github.com/caldwell/gdisk/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.9-build_flags.patch
	"${FILESDIR}"/${PN}-1.0.10_utf16-to-utf8-conversion.patch
)

src_prepare() {
	default

	tc-export CXX PKG_CONFIG

	if ! use ncurses ; then
		sed -i \
			-e '/^all:/s: cgdisk::' \
			Makefile || die
	fi

	sed \
		-e '/g++/s:=:?=:g' \
		-e 's:-lncursesw:$(shell $(PKG_CONFIG) --libs ncursesw):g' \
		-i Makefile || die

	use static && append-ldflags -static
}

src_install() {
	dosbin gdisk sgdisk $(usex ncurses cgdisk '') fixparts
	doman *.8
	dodoc NEWS README
}
