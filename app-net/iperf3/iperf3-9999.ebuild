# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A network traffic tool for measuring TCP and UDP performance"
HOMEPAGE="https://sourceforge.net/projects/iperf2/"
EGIT_REPO_URI="https://github.com/esnet/iperf"

LICENSE="BSD"
SLOT="0"
SONAME="3"
KEYWORDS="amd64 arm64"

src_install() {
		default
		mv "${ED}"/usr/bin/iperf "${ED}"/usr/bin/iperf3
}
