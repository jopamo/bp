# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The LXQt session manager"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
