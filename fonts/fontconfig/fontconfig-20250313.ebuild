# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"


SNAPSHOT=fdfc3445d1cc9c1c7e587fb2a1287871de16faf9
SRC_URI="https://gitlab.freedesktop.org/fontconfig/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

