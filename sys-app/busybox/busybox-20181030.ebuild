# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.busybox.net/busybox"
	EGIT_BRANCH="1_29_stable"
else
	SNAPSHOT=93ef5dd640ef41edc72c80fa59c7cc9427b5945b
	SRC_URI="https://git.busybox.net/busybox/snapshot/${PN}-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2" # GPL-2 only
SLOT="0"
RESTRICT="test"

src_prepare() {
	default
	cp "${FILESDIR}"/busybox-config "${S}"/.config
}

src_install() {
	dobin busybox
	dosym busybox usr/bin/sha3sum
	dosym busybox usr/bin/unzip
	dosym busybox usr/bin/whois
	dosym busybox usr/bin/which
}
