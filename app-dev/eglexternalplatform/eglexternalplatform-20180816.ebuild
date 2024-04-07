# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="specification of the EGL External Platform interface"
HOMEPAGE="https://github.com/NVIDIA/eglexternalplatform"

SNAPSHOT=7c8f8e2218e46b1a4aa9538520919747f1184d86
SRC_URI="https://github.com/NVIDIA/eglexternalplatform/archive/${SNAPSHOT}.tar.gz -> eglexternalplatform-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/eglexternalplatform-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto usr/include/EGL
	doins -r interface/*

	insinto usr/share/pkgconfig
	doins eglexternalplatform.pc
}
