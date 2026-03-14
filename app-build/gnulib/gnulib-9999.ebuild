# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GNU portability library for reusable code"
HOMEPAGE="https://savannah.gnu.org/projects/gnulib"
EGIT_REPO_URI="https://github.com/coreutils/gnulib"

LICENSE="GPL-3+ LGPL-2.1+ FDL-1.3+"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_compile() { :; }

src_install() {
	mkdir -p "${ED}"/usr/share || die
	git clone -q --no-local "${S}" "${ED}"/usr/share/gnulib || die
	git -C "${ED}"/usr/share/gnulib remote set-url origin "${EGIT_REPO_URI%% *}" || die
	dosym ../share/gnulib/gnulib-tool /usr/bin/gnulib-tool
}
