# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.busybox.net/busybox"
	EGIT_BRANCH="$(ver_cut 1)_$(ver_cut 2)_stable"
else
	SNAPSHOT=a92a9601f89d59597b268e29e7098597a8766778
	SRC_URI="https://git.busybox.net/busybox/snapshot/${PN}-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

KEYWORDS="amd64 arm64"

LICENSE="GPL-2" # GPL-2 only
SLOT="0"
RESTRICT="test"

filter-flags -flto

src_prepare() {
	default
	cp "${FILESDIR}"/busybox-config "${S}"/.config
	make oldconfig
}

src_install() {
	dobin busybox
	dosym busybox usr/bin/sha3sum
	dosym busybox usr/bin/unzip
	dosym busybox usr/bin/whois
	dosym busybox usr/bin/which
}
