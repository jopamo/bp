# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="Oniguruma-compatible regular expressions library fork"
HOMEPAGE="https://gitlab.com/pjo/libonig"
SNAPSHOT=b2ca23503a081450a34f2adee874f3947f0fc121
SRC_URI="https://gitlab.com/pjo/libonig/-/archive/${SNAPSHOT}/libonig-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libonig-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"
RESTRICT="!test? ( test )"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dbuild_tests=$(usex test true false)
		-Dbuild_samples=false
		-Dinstall_examples=false
		-Ddefault_library=$(usex static-libs both shared)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
