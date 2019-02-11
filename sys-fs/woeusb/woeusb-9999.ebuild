# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="WoeUSB  creates a Windows USB stick installer from a real Windows DVD or image."
HOMEPAGE="https://github.com/slacka/WoeUSB"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/slacka/${PN}.git"
	KEYWORDS="amd64 x86"
else
	SRC_URI="https://github.com/slacka/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	S="${WORKDIR}/WoeUSB-${PV}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="sys-app/sed"
RDEPEND="sys-app/coreutils
	sys-app/busybox
	sys-app/util-linux
	sys-fs/parted
	sys-app/grub:2
	sys-fs/ntfs3g
	sys-fs/dosfstools"

PATCHES=( "${FILESDIR}"/woeusb_only_for_gui_ref.patch )

src_install() {
	sed -i.bak -e "s/@@WOEUSB_VERSION@@/${PV}/g" "src/woeusb"
	dosbin src/woeusb
	doman src/woeusb.1
}
