# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1 flag-o-matic

DESCRIPTION="a fast cryptographic hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"
SNAPSHOT=4d115fc534f1a58061ddf2f6d73d19f0ed8c6787
SRC_URI="https://github.com/jopamo/BLAKE3/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/BLAKE3-${SNAPSHOT}"

LICENSE="|| ( CC0-1.0 Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static_lib +shared static_bin test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( ${PYTHON_DEPS} )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}/dedup_symlink" "${S}/" || die "Failed to copy dedup_symlink"
    sed -i "s/VERSION/${PV}/g" "${S}/src/b3sum.c" || die "Failed to replace VERSION in b3sum.c"
    sed -i "s/VERSION/${PV}/g" "${S}/meson.build" || die "Failed to replace VERSION in meson.build"

    default
}

src_configure() {
    local emesonargs=(
        -Dbuild_static_lib=$(usex static_lib true false)
        -Dbuild_shared_lib=$(usex shared true false)
        -Dbuild_static_b3sum=$(usex static_bin true false)
    )
    meson_src_configure
}

src_install() {
    meson_src_install

    dobin dedup_symlink
}
