# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=f0d3ed17ef3b2bbdfdff4dde12ec0a82d1ccdd33

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/popt"
BDEPEND="dev-util/pkgconf"
