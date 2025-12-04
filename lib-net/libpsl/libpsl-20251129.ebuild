# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C library for the Public Suffix List"
HOMEPAGE="https://github.com/jopamo/libpsl"
SNAPSHOT=0f6613bcce9378fa7842d44e9ef478f25f01812b
SRC_URI="https://github.com/jopamo/libpsl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
