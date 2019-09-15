# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=1a52f1fc0266d438c996789d4addbfac999a6139

inherit flag-o-matic systemd toolchain-funcs

DESCRIPTION="Tool for running RAID systems - replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"
SRC_URI="https://git.kernel.org/pub/scm/utils/${PN}/${PN}.git/snapshot/${PN}-1a52f1fc0266d438c996789d4addbfac999a6139.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="dev-util/pkgconf
		app-compression/xz-utils"
RDEPEND="sys-app/util-linux"

RESTRICT="test"

PATCHES=( ${FILESDIR}/mdadm-portage.patch )

mdadm_emake() {
	emake \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		CC="$(tc-getCC)" \
		CWFLAGS="-Wall -DBINDIR=\"/usr/sbin\"" \
		CXFLAGS="${CFLAGS}" \
		UDEVDIR="${EPREFIX}"/usr/lib/udev/rules.d \
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
	insinto /etc
	newins mdadm.conf-example mdadm.conf
}
