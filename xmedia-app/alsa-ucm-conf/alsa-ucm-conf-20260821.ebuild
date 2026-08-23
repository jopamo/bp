# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="ALSA Use Case Manager configuration"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=00175aa645c482111d096c3d8230f182a875d286
SRC_URI="https://github.com/alsa-project/alsa-ucm-conf/archive/${SNAPSHOT}.tar.gz -> alsa-ucm-conf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/alsa-ucm-conf-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/alsa/
	doins -r ucm2
}
