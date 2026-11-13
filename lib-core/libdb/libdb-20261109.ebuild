# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=b32e16c84d0f2b9e008798aeb17dfb218dbe670a
EGIT_REPO_URI="https://github.com/berkeleydb/libdb.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit git-snapshot

DESCRIPTION="Community continuation of the Berkeley DB 5.3 database library"
HOMEPAGE="https://github.com/berkeleydb/libdb"
LICENSE="Sleepycat"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}/libdb-repmgr-address-family.patch" )

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

src_test() {
	emake -C "${WORKDIR}/build" test
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" \
		install_include install_lib install_utilities
}
