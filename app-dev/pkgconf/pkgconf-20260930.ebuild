# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"
SNAPSHOT=d908d63634c13b9a4f88d2fe4578d95048a6b13c
SRC_URI="https://github.com/pkgconf/pkgconf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pkgconf-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	dosym -r /usr/bin/pkgconf /usr/bin/pkg-config
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
