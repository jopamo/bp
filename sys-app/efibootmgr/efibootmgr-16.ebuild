# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"
SRC_URI="https://github.com/rhboot/efibootmgr/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

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
