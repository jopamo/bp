# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Headers for Video Decode and Presentation API for UNIX"
HOMEPAGE="https://github.com/freedesktop/libvdpau"
EGIT_REPO_URI="https://github.com/freedesktop/libvdpau.git"

LICENSE="nvidia"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_install() {
	insinto usr/include/vdpau/
	doins include/vdpau/*
}
