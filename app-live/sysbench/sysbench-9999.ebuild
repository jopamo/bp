# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Scriptable database and system performance benchmark"
HOMEPAGE="https://github.com/akopytov/sysbench.git"
EGIT_REPO_URI="https://github.com/akopytov/sysbench.git"

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
