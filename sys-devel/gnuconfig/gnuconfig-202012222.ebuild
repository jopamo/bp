# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="https://savannah.gnu.org/projects/config"

SNAPSHOT=c8ddc8472f8efcadafc1ef53ca1d863415fddd5f
SRC_URI="https://git.savannah.gnu.org/cgit/config.git/snapshot/config-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/config-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() { :;}

src_test() {
	emake check
}

src_install() {
	insinto /usr/share/${PN}
	doins config.{sub,guess} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
	cleanup_install
}
