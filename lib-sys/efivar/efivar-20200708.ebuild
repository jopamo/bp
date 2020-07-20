# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=36297adcb266f07bb06e725a0da377bc6e6aedd0

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/popt"
BDEPEND="dev-util/pkgconf"
