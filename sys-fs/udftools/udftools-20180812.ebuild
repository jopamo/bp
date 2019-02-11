# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
HOMEPAGE="https://github.com/pali/udftools/ https://sourceforge.net/projects/linux-udf/"
SRC_URI="https://github.com/pali/udftools/releases/download/${PV}/${P}.tar.gz"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pali/udftools.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=9c4af0f9d2e7c6329fab5901ab6dd0cbd603e930
	SRC_URI="https://github.com/pali/udftools/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="lib-sys/readline:0="
DEPEND="${RDEPEND}"
