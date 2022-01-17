# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

SNAPSHOT=1753149d4176ebfb2b135ac0aaf79340bf0e7a93

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -flto\*

src_compile() {
	emake libdir="/usr/lib/" \
		bindir="/usr/bin/" \
		mandir="/usr/share/man/" \
		includedir="/usr/include/"
}

src_install() {
	emake DESTDIR="${ED}" \
		libdir="/usr/lib/" \
		bindir="/usr/bin/" \
		mandir="/usr/share/man/" \
		includedir="/usr/include/" install -j1 V=1
}
