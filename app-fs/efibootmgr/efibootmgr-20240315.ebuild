# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=0a85e9baaac8a34e4a0bb9c23dfcc9c4f759e061

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"
SRC_URI="https://github.com/rhboot/efibootmgr/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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

src_configure() {
	export EFIDIR="1g4"
}
