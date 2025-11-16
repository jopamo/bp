# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SNAPSHOT=2896c47337d8b13a54d2f58f2829af4edb88230a
SRC_URI="https://github.com/gentoo/gentoolkit/archive/${SNAPSHOT}.tar.gz -> gentoolkit-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gentoolkit-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-core/portage
		app-core/gentoo-functions"
