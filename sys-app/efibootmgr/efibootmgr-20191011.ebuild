# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

SNAPSHOT=e8ce9fecebd15adb4c60a0678d4c417afe06dde4

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
