# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scriptable database and system performance benchmark"
HOMEPAGE="https://github.com/akopytov/sysbench.git"

SNAPSHOT=3ceba0b1e115f8c50d1d045a4574d8ed643bd497
SRC_URI="https://github.com/akopytov/sysbench/archive/${SNAPSHOT}.tar.gz -> sysbench-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sysbench-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/luajit"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-mysql
		--with-system-luajit
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
