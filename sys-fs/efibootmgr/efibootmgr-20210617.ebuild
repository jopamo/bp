# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=4069341e184471dccf407ca8410daa4c4fd634f5

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"
SRC_URI="https://github.com/rhboot/efibootmgr/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/pciutils
	sys-fs/efivar
	lib-core/popt
"


src_prepare() {
	default
	sed -i -e s/-Werror// Make.defaults || die
}

src_configure() {
	export EFIDIR="1g4"
}
