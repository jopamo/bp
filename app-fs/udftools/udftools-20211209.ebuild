# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Linux tools for UDF filesystems and DVD/CD-R(W) drives"
HOMEPAGE="https://github.com/pali/udftools/ https://sourceforge.net/projects/linux-udf/"

SNAPSHOT=77a198f4ea011cdeb051e1c860e5a89c740c8fa8
SRC_URI="https://github.com/pali/udftools/archive/${SNAPSHOT}.tar.gz -> udftools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/udftools-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/readline:0="

src_prepare() {
	default
	eautoreconf
}
