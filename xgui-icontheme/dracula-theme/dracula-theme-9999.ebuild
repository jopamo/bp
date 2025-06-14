# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Dracula gtk theme"
HOMEPAGE="https://github.com/dracula/gtk"

EGIT_REPO_URI="https://github.com/dracula/dracula-theme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

EGIT_SUBMODULES=( 'gtk' )

src_install() {
	insinto /usr/share/themes/dracula
	doins -r themes/gtk/*
}
