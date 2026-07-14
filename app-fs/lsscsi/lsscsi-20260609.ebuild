# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"

SNAPSHOT=94bf08419fe635d6e437b93aa36972ef3510fcee
SRC_URI="https://github.com/doug-gilbert/lsscsi/archive/${SNAPSHOT}.tar.gz -> lsscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lsscsi-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
