# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="NVMe management command line interface"
HOMEPAGE="https://github.com/linux-nvme/nvme-cli"
SNAPSHOT=a57c1b39712993e8b83ac9ba6cbdaa6b57b8c4c8
SRC_URI="https://github.com/linux-nvme/nvme-cli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
