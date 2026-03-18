# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="NVMe management command line interface"
HOMEPAGE="https://github.com/linux-nvme/nvme-cli"
SNAPSHOT=cd3c69127887967d95b0d83adb2d5276b701c480
SRC_URI="https://github.com/linux-nvme/nvme-cli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
