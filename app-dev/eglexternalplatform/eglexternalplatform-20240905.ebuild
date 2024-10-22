# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="specification of the EGL External Platform interface"
HOMEPAGE="https://github.com/NVIDIA/eglexternalplatform"

SNAPSHOT=cf9f10589775c1b4d90f1df6f417f8cf1bed7ec6
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
