# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic systemd toolchain-funcs

DESCRIPTION="Tool for running RAID systems - replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://neil.brown.name/mdadm"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://mirrors.edge.kernel.org/pub/linux/utils/raid/mdadm/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi
LICENSE="GPL-2"
SLOT="0"
IUSE="static"

DEPEND="dev-util/pkgconfig
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
		UDEVDIR="$(get_udevdir)" \
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
