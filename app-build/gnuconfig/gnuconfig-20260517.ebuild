# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="https://savannah.gnu.org/projects/config"
SNAPSHOT=428664896cf9e92d264976a960c76660938dffce
SRC_URI="https://github.com/1g4-mirror/config/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/config-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() { :;}

src_test() {
	emake check
}

src_install() {
	insinto /usr/share/gnuconfig
	doins config.{sub,guess} || die
	fperms +x /usr/share/gnuconfig/config.{sub,guess}
	doman doc/config.{sub,guess}.1 || die
	cleanup_install
}
