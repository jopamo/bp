# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="A TCP-IP emulator used to provide virtual networking services"
HOMEPAGE="https://gitlab.freedesktop.org/slirp/libslirp"

UPSTREAM_PV=4.9.1
SNAPSHOT=97b325339a1377249e68e6c58e9c15a6e1bba4c1
SRC_URI="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/${SNAPSHOT}/lib${PN}-${SNAPSHOT}.tar.bz2 -> lib${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/lib${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_prepare() {
	echo "${UPSTREAM_PV}.${PV}" > .tarball-version || die
	echo -e "#!${BASH}\necho -n \$(cat '${S}/.tarball-version')" > build-aux/git-version-gen || die
	default
}

src_configure() {
	qa-policy-configure
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
