# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A TCP-IP emulator used to provide virtual networking services"
HOMEPAGE="https://gitlab.freedesktop.org/slirp/libslirp"

SNAPSHOT=129077f9870426d1b7b3a8239d8b5a50bee017b4
SRC_URI="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/${SNAPSHOT}/lib${PN}-${SNAPSHOT}.tar.bz2 -> lib${P}.tar.bz2"
S=${WORKDIR}/lib${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_prepare() {
	echo "${PV}" > .tarball-version || die
	echo -e "#!${BASH}\necho -n \$(cat '${S}/.tarball-version')" > build-aux/git-version-gen || die
	default
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}
