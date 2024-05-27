# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://github.com/EHfive/ldacBT"

SNAPSHOT=976973c758c526ee880e5a3e99b70b08345e9397
SRC_URI="https://github.com/Dav1dde/glad/archive/${SNAPSHOT}.tar.gz -> glad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glad-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
