# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1

DESCRIPTION="a fast cryptographic hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"
SNAPSHOT=8feae888c3a83b52fcc94a05dc2945f40223cbc7
SRC_URI="https://github.com/jopamo/blake3/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
