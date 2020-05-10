# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

SNAPSHOT=edc8b9b6ec1c7751ccb9a483405c99141ba237fc

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"
SRC_URI="https://github.com/rhboot/efibootmgr/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="sys-app/pciutils
	>=lib-sys/efivar-25:="
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -e s/-Werror// Make.defaults || die
}

src_configure() {
	tc-export CC
	export EFIDIR="1g4"
}
