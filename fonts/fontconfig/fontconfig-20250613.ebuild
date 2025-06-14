# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SNAPSHOT=41f2ae7df48d192b938ab78217bece1fab09dd1b
SRC_URI="https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${SNAPSHOT}/fontconfig-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/fontconfig-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

