# Distributed under the terms of the GNU General Public License v2

inherit meson xdg

DESCRIPTION="freedesktop default icon theme"
HOMEPAGE="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"
SNAPSHOT=8d22bbf304775a3cc109a2220e633cafda50eaac
SRC_URI="https://gitlab.freedesktop.org/xdg/default-icon-theme/-/archive/${SNAPSHOT}/default-icon-theme-${SNAPSHOT}.tar.bz2 -> default-icon-theme-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/default-icon-theme-${SNAPSHOT}"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	meson_src_install

	local dir
	while IFS= read -r dir; do
		keepdir "/usr/share/icons/hicolor/${dir}"
	done < <(
		awk '
			/^\[[^][]+\]$/ {
				section = substr($0, 2, length($0) - 2)
				if (section != "Icon Theme")
					print section
			}
		' index.theme
	)
}
