# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="NVMe management command line interface"
HOMEPAGE="https://github.com/linux-nvme/nvme-cli"
SNAPSHOT=ed28a52d3bfd9ee59d37e04e609fe74b1b68f642
SRC_URI="https://github.com/linux-nvme/nvme-cli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

DEPEND="virtual/ssl"

filter-flags -Wl,-z,defs
