# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hreinecke/lsscsi.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=8d34e7ddbabc69e04ae5b28dc14aa3a448cc3201
	SRC_URI="https://github.com/hreinecke/lsscsi/archive/${SNAPSHOT}.zip -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"
