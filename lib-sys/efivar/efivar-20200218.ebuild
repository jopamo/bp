# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

SNAPSHOT=0e42eb90521c8cd4f67196c6620c0672c1106f2c

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/popt"
BDEPEND="dev-util/pkgconf"
