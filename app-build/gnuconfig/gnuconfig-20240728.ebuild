# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="https://savannah.gnu.org/projects/config"

SNAPSHOT=00b15927496058d23e6258a28d8996f87cf1f191
SRC_URI="https://github.com/1g4-mirror/config/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/config-${SNAPSHOT}"

LICENSE="GPL-2"
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
	cleanup_install
}
