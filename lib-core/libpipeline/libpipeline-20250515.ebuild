# Distributed under the terms of the GNU General Public License v2

inherit qa-policy gl

DESCRIPTION="a pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"

SNAPSHOT=08844b33bd0c77c7567caf1641f3aa48045f3e3b
SRC_URI="https://gitlab.com/libpipeline/libpipeline/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_prepare() {
	qa-policy-configure

	# New gnulib exposes verror declarations from <error.h>; verror.h was dropped.
	sed -i 's|#include "verror.h"|#include <error.h>|' lib/fatal.c || die

	gl_stage_gnulib
	./bootstrap --no-git --gnulib-srcdir="${S}/gnulib" || die

	default
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
}
