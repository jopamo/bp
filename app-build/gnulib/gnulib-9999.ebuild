# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GNU portability library for reusable code"
HOMEPAGE="https://savannah.gnu.org/projects/gnulib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

src_unpack() {
	mkdir -p "${S}"
	git clone --depth 5000 https://github.com/coreutils/gnulib "${S}" || die
}

src_compile() { :;}

src_test() { :;}

src_install() {
	mkdir -p "${ED}"/usr/share
	cp -r "${S}" "${ED}"/usr/share/gnulib
}
