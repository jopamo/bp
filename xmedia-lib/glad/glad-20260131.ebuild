# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://glad.dav1d.de/"
SNAPSHOT=a4ca574522ff69d0bb584584977aa9a53ace29d9
SRC_URI="https://github.com/Dav1dde/glad/archive/${SNAPSHOT}.tar.gz -> glad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glad-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
