# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"

SNAPSHOT=e1c6699ebd0dc1867f13492d33d5f20feb606bf0
SRC_URI="https://github.com/doug-gilbert/lsscsi/archive/${SNAPSHOT}.tar.gz -> lsscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lsscsi-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
