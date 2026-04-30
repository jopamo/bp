# Distributed under the terms of the GNU General Public License v2

inherit meson python-any-r1

DESCRIPTION="a fast cryptographic hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"

SNAPSHOT=3cfa221234172b117de2a5e227c8f7cf4e4e911f
SRC_URI="https://gitlab.com/pjo/b3/-/archive/${SNAPSHOT}/b3-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/b3-${SNAPSHOT}"

LICENSE="|| ( CC0-1.0 Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static_lib shared static_bin test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( ${PYTHON_DEPS} )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}/b3-cat" "${S}/" || die "Failed to copy v3-cat"
	cp "${FILESDIR}/dedup_symlink" "${S}/" || die "Failed to copy dedup_symlink"
    sed -i "s/VERSION/${PV}/g" "${S}/src/b3sum.c" || die "Failed to replace VERSION in b3sum.c"
    sed -i "s/VERSION/${PV}/g" "${S}/meson.build" || die "Failed to replace VERSION in meson.build"

    default
}

src_install() {
    meson_src_install

    dobin dedup_symlink
    dobin b3-cat
}
