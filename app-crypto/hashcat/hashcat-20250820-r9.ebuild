# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="World's fastest and most advanced password recovery utility"
HOMEPAGE="https://github.com/hashcat/hashcat"
SNAPSHOT=8be044579c8ccda8aada16c5359cc0c0719eb8b4
SRC_URI="https://github.com/hashcat/hashcat/archive/${SNAPSHOT}.tar.gz -> hashcat-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hashcat-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="custom-cflags nvidia"

RESTRICT="network-sandbox"

src_prepare() {
	append-flags -ffat-lto-objects

	#do not strip
	sed -i "/LFLAGS                  += -s/d" src/Makefile
	#do not add random CFLAGS
	sed -i "s/-O2//" src/Makefile || die
	cd "${S}"
	git submodule update --init
	export PREFIX=/usr
	export LIBRARY_FOLDER="/usr/lib"
	eapply_user
}

src_test() {
	if use nvidia; then
		addwrite /dev/nvidia0
		addwrite /dev/nvidiactl
		addwrite /dev/nvidia-uvm
		if [ ! -w /dev/nvidia0 ]; then
			einfo "To run these tests, portage likely must be in the video group."
			einfo "Please run \"gpasswd -a portage video\" if the tests will fail"
		fi
	fi
	./hashcat -a 3 -m 1500 nQCk49SiErOgk || die "Test failed"
}
