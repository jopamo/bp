# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="NVMe management command line interface"
HOMEPAGE="https://github.com/linux-nvme/nvme-cli"
SNAPSHOT=7e89b0de2993047d1f74635371de0c496c871e10
SRC_URI="https://github.com/linux-nvme/nvme-cli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
