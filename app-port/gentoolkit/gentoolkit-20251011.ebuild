# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SNAPSHOT=88a4a0cac2aaf80c45a7444ba842ce8dcc6dccda
SRC_URI="https://github.com/gentoo/gentoolkit/archive/${SNAPSHOT}.tar.gz -> gentoolkit-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gentoolkit-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-core/portage
		app-core/gentoo-functions"
