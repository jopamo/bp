# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SNAPSHOT=ece2a676c67b7d8d599ccce3051b0463404027f6
SRC_URI="https://github.com/p11-glue/p11-kit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"
