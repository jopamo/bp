# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic multilib systemd toolchain-funcs udev

DESCRIPTION="Tool for running RAID systems - replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/neilbrown/mdadm.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=5d518de84e7cd3382b4984cc1243ddb4102aa4f4
	SRC_URI="https://github.com/neilbrown/mdadm/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
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
