# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Data files for poppler to support uncommon encodings without xpdfrc"
HOMEPAGE="https://poppler.freedesktop.org/"

SNAPSHOT=3d16b54346767f2e69c3dcd09d28d762d4a4add5
SRC_URI="https://gitlab.freedesktop.org/poppler/poppler-data/-/archive/${SNAPSHOT}/poppler-data-${SNAPSHOT}.tar.bz2 -> poppler-data-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/poppler-data-${SNAPSHOT}"

LICENSE="BSD GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
