# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scriptable database and system performance benchmark"
HOMEPAGE="https://github.com/akopytov/sysbench.git"

SNAPSHOT=de18a036cc65196b1a4966d305f33db3d8fa6f8e
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
