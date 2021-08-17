# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/dosfstools/dosfstools.git"
	inherit git-r3
else
	SNAPSHOT=f414e322da17c628a69ef61409b06b8f03e5a17c
	SRC_URI="https://github.com/dosfstools/dosfstools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="udev"

DEPEND="sys-devel/gettext
	udev? ( app-core/systemd )"

src_prepare() {
	cp "${EROOT}"/usr/share/gettext/config.rpath ${S}/
	default
	eautoreconf
}

src_configure() {
	econf $(use_with udev)
}
