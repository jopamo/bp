# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="specification of the EGL External Platform interface"
HOMEPAGE="https://github.com/NVIDIA/eglexternalplatform"
EGIT_REPO_URI="https://github.com/NVIDIA/eglexternalplatform"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto usr/include/EGL
	doins -r interface/*

	insinto usr/share/pkgconfig
	doins eglexternalplatform.pc
}
