# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jinja
"
# lockstep-pypi-deps: end
DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://glad.dav1d.de/"
SNAPSHOT=e3c14f906127dea49ead20ff4d5878294d08b7ab
SRC_URI="https://github.com/Dav1dde/glad/archive/${SNAPSHOT}.tar.gz -> glad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glad-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
