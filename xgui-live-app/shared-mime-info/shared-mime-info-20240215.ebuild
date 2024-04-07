# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"

SNAPSHOT=091b9b604fd29b622067afb6a69fb63109c978e5
SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${SNAPSHOT}/shared-mime-info-${SNAPSHOT}.tar.bz2 -> shared-mime-info-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/shared-mime-info-${SNAPSHOT}"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info"
	inherit
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=091b9b604fd29b622067afb6a69fb63109c978e5
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
