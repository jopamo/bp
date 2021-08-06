# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit git-r3 cmake flag-o-matic

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator based on the official specs."
HOMEPAGE="https://glad.dav1d.de/"
EGIT_REPO_URI="https://github.com/Dav1dde/glad.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs

src_install() {
	dolib.so "${BUILD_DIR}"/libglad.so

	for x in libglad.so.1 libglad.so.1.0 ; do
		dosym libglad.so usr/lib/${x}
	done

	insinto /usr/include
	doins -r "${BUILD_DIR}"/include/*

	rm "${ED}"/usr/include/KHR/khrplatform.h
}
