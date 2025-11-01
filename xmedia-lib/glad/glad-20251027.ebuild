# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://github.com/EHfive/ldacBT"
SNAPSHOT=27bed1181560211b55e39a9b132fef8c5846aae5
SRC_URI="https://github.com/Dav1dde/glad/archive/${SNAPSHOT}.tar.gz -> glad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glad-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
