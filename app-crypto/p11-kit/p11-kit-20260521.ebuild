# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SNAPSHOT=c5d5130c6610760151e61df9fede4826f765e7ef
SRC_URI="https://github.com/p11-glue/p11-kit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"
