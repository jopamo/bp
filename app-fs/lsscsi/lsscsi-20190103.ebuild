# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"

SNAPSHOT=8d34e7ddbabc69e04ae5b28dc14aa3a448cc3201
SRC_URI="https://github.com/hreinecke/lsscsi/archive/${SNAPSHOT}.tar.gz -> lsscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lsscsi-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
