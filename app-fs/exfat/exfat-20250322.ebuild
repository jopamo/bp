# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="exFAT filesystem FUSE module"
HOMEPAGE="https://github.com/relan/exfat"

SNAPSHOT=524a78f7d785d4adfc017a90af8a5918adf628c8
SRC_URI="https://github.com/relan/exfat/archive/${SNAPSHOT}.tar.gz -> exfat-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/exfat-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-fs/fuse:3"

src_prepare() {
	default
	eautoreconf
}
