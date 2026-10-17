# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=5e00a8b5e17afac346816a60dbe876b1881c6990
EGIT_REPO_URI="https://github.com/berkeleydb/libdb.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit git-snapshot

DESCRIPTION="Community continuation of the Berkeley DB 5.3 database library"
HOMEPAGE="https://github.com/berkeleydb/libdb"
LICENSE="Sleepycat"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	mkdir -p "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	ECONF_SOURCE="${S}/dist" econf \
		--enable-shared \
		--disable-static \
		--enable-cxx \
		--without-uring
}

src_compile() {
	emake -C "${WORKDIR}/build"
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" \
		install_include install_lib install_utilities
}
