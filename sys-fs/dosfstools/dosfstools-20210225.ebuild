# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/dosfstools/dosfstools.git"
	inherit git-r3
else
	SNAPSHOT=5fe59602a937e5ce5f4890fd2e4a27ae50e2b082
	SRC_URI="https://github.com/dosfstools/dosfstools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="udev"

DEPEND="sys-devel/gettext
	udev? ( sys-app/systemd )"

src_prepare() {
	cp "${EROOT}"/usr/share/gettext/config.rpath ${S}/
	default
	eautoreconf
}

src_configure() {
	econf $(use_with udev)
}
