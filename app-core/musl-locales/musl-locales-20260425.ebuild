# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="Locale program for musl libc"
HOMEPAGE="https://git.adelielinux.org/adelie/musl-locales"
SNAPSHOT=f6f3cf5fc1ebc1e220c74a4e73c4586d698b4c00
SRC_URI="https://git.adelielinux.org/adelie/musl-locales/-/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="!lib-core/glibc"
BDEPEND="app-build/gettext"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DLOCALE_PROFILE=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
