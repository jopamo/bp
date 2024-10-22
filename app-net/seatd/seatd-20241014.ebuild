# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Minimal seat management daemon and universal library"
HOMEPAGE="https://sr.ht/~kennylevinsen/seatd"

SNAPSHOT=5d2b3e95d82490dd6c1013752996c1ed43247820
SRC_URI="https://github.com/kennylevinsen/seatd/archive/${SNAPSHOT}.tar.gz -> seatd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/seatd-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

src_install() {
	meson_src_install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins contrib/systemd/seatd.service
	fi
}
