# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Minimal seat management daemon and universal library"
HOMEPAGE="https://sr.ht/~kennylevinsen/seatd"
EGIT_REPO_URI="https://github.com/kennylevinsen/seatd"

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
