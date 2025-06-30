# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 flag-o-matic

DESCRIPTION="Firmware Analysis Tool"
HOMEPAGE="https://github.com/ReFirmLabs/binwalk"
EGIT_REPO_URI="https://github.com/ReFirmLabs/binwalk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

replace-flags -Os -O3
filter-flags -Os

src_install() {
	newbin "$(cargo_target_dir)/binwalk" binwalk3
}
