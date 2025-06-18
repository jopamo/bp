# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=1904f9cd5a48207d49e393ac8de824f54ccfb697

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"
SRC_URI="https://github.com/rhboot/efibootmgr/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/pciutils
	app-fs/efivar
	lib-core/popt
"


src_prepare() {
	default
	sed -i -e s/-Werror// Make.defaults || die
}

src_compile() {
	emake \
		DESTDIR="${ED}" \
		libdir=/usr/lib \
		sbindir=/usr/bin \
		EFIDIR=1g4
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		libdir=/usr/lib \
		sbindir=/usr/bin \
		EFIDIR=1g4 \
		install
}
