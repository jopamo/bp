# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Library providing generic access to the PCI bus and devices"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"
else
	SRC_URI="https://www.x.org/archive/individual/lib/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
