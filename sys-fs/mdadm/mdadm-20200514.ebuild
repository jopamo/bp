# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=3b7aae927bdb6e150d1aaf3aaf0d183a06abda0b

inherit flag-o-matic systemd toolchain-funcs

DESCRIPTION="Tool for running RAID systems - replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"
SRC_URI="https://git.kernel.org/pub/scm/utils/${PN}/${PN}.git/snapshot/${PN}-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="dev-util/pkgconf
	app-compression/xz-utils
	sys-app/util-linux"

RESTRICT="test"

PATCHES=( "${FILESDIR}"/mdadm-portage.patch )

mdadm_emake() {
	emake \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		CC="$(tc-getCC)" \
		CWFLAGS="-Wall -DBINDIR=\"/usr/sbin\"" \
		CXFLAGS="${CFLAGS}" \
		UDEVDIR="${EPREFIX}"/usr/lib/udev \
		SYSTEMD_DIR="$(systemd_get_systemunitdir)" \
		COROSYNC="-DNO_COROSYNC" \
		DLM="-DNO_DLM" \
		"$@"
}

src_compile() {
	use static && append-ldflags -static
	mdadm_emake all
}

src_test() {
	mdadm_emake test
	sh ./test || die
}

src_install() {
	mdadm_emake DESTDIR="${D}" install install-systemd
	insinto etc/mdadm
	doins ${FILESDIR}/mdadm.conf
}
