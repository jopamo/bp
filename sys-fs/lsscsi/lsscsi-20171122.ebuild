# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hreinecke/lsscsi.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=c6afad0cc983096fe6f8870c30c5f63076c94c03
	SRC_URI="https://github.com/hreinecke/lsscsi/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
