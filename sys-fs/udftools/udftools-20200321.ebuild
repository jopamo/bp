# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
HOMEPAGE="https://github.com/pali/udftools/ https://sourceforge.net/projects/linux-udf/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pali/udftools.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=d07c322f72df571ebdd0e1a596b557a604aacfb8
	SRC_URI="https://github.com/pali/udftools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-sys/readline:0="
