# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="A TCP-IP emulator used to provide virtual networking services"
HOMEPAGE="https://gitlab.freedesktop.org/slirp/libslirp"

SNAPSHOT=392af90207fc51dd9f9044ee9b1f963f3c851c2c
SRC_URI="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/${SNAPSHOT}/lib${PN}-${SNAPSHOT}.tar.bz2 -> lib${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/lib${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_prepare() {
	local project_version=

	project_version=$(sed -nE "/^[[:space:]]*version[[:space:]]*:/ { s/^[[:space:]]*version[[:space:]]*:[[:space:]]*['\\\"]([^'\\\"]+)['\\\"].*/\\1/p; q; }" meson.build) || die
	[[ -n ${project_version} ]] || die "failed to extract project version from meson.build"

	printf '%s\n' "${project_version}.${PV}" > .tarball-version || die
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
