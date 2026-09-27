# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="ALSA Use Case Manager configuration"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=18d142f3bfc9f59cecb4e6d65013da8c8cdccb65
SRC_URI="https://github.com/alsa-project/alsa-ucm-conf/archive/${SNAPSHOT}.tar.gz -> alsa-ucm-conf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/alsa-ucm-conf-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/alsa/
	doins -r ucm2
}
