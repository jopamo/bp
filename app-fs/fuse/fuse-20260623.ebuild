# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"
SNAPSHOT=dbbf3cf77880e363224c8f06920490aefb394204
SRC_URI="https://github.com/libfuse/libfuse/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfuse-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"
PATCHES=( "${FILESDIR}"/${PN}-clang-compat.patch )

src_prepare() {
	if use elibc_musl; then
		eapply "${FILESDIR}"/${PN}-include-paths-h.patch
	fi

	default
}

src_configure() {
#	filter-flags -flto*

	local emesonargs=(
		-Dtests=false
		-Dexamples=false
		-Duseroot=false
		-Dutils=true
		-Dinitscriptdir=""
	)
	meson_src_configure
}

src_install() {
	local MESON_SOURCE_ROOT="${S}"

	meson_src_install
	rm -rf "${ED}"/etc/init.d
}
