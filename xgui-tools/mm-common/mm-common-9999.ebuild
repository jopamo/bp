# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-any-r1 meson git-r3

DESCRIPTION="Build infrastructure and utilities for GNOME C++ bindings"
HOMEPAGE="https://www.gtkmm.org/ https://gitlab.gnome.org/GNOME/mm-common"
EGIT_REPO_URI="https://github.com/GNOME/mm-common.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_configure() {
	local -a emesonargs=(
		-Duse-network=true
	)
	meson_src_configure
}
