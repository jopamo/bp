# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SNAPSHOT=02f05a69cbd955f2263a80090171039d05328858
SRC_URI="https://github.com/gentoo/gentoolkit/archive/${SNAPSHOT}.tar.gz -> gentoolkit-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gentoolkit-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-core/portage
		app-core/gentoo-functions"
