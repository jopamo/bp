# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A lightweight and fast battery icon that sits in your system tray"
HOMEPAGE="https://github.com/valr/cbatticon"

SNAPSHOT=3d832c73452ce071c156216135c2d368ba7d496a
SRC_URI="https://github.com/valr/cbatticon/archive/${SNAPSHOT}.tar.gz -> cbatticon-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cbatticon-${SNAPSHOT}"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/valr/cbatticon"
	inherit
else
	SRC_URI="https://github.com/valr/cbatticon/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake \
		V=1 \
		VERSION="${PF}" \
		WITH_NOTIFY=0 \
		WITH_GTK3=1
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LANGUAGES="${LINGUAS}" \
		V=1 VERSION="${PF}" \
		install
	default
}
