# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Minimal seat management daemon and universal library"
HOMEPAGE="https://sr.ht/~kennylevinsen/seatd"
SNAPSHOT=737d3ca4e63ae0f4ff38481628346da384d9f774
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
