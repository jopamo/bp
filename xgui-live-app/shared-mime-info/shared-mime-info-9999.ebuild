# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info.git"
	inherit git-r3
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=b969e1c74e7c905a96c1590f5350a264dbaa83ae
	SRC_URI="https://gitlab.freedesktop.org/xdg/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
else
	SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${PV}/${P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-core/libxml2"
DEPEND="lib-live/glib"
