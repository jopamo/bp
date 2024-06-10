# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://github.com/EHfive/ldacBT"

SNAPSHOT=2ae8255a60f3ca529a4db079161c3f8c120f178d
SRC_URI="https://github.com/Dav1dde/glad/archive/${SNAPSHOT}.tar.gz -> glad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glad-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
