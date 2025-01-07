# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1 flag-o-matic

DESCRIPTION="a fast cryptographic hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"

SNAPSHOT=5c8b350b3531102359b89e9f0a3367e6de4a43f4
SRC_URI="https://github.com/BLAKE3-team/BLAKE3/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/BLAKE3-${SNAPSHOT}/c"

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
	cp "${FILESDIR}/b3sum.c" "${S}/" || die "Failed to copy b3sum.c"
	cp "${FILESDIR}/dedup_symlink" "${S}/" || die "Failed to copy dedup_symlink"
	cp "${FILESDIR}/meson.build" "${S}/" || die "Failed to copy meson.build"
	cp "${FILESDIR}/check_cpu_features.py" "${S}/" || die "Failed to copy check_cpu_features.py"

	echo "option('build_static_lib', type: 'boolean', value: false, description: 'Build static library (libblake3.a)')" > meson_options.txt
    echo "option('build_shared_lib', type: 'boolean', value: true, description: 'Build shared library (libblake3.so)')" >> meson_options.txt
    echo "option('build_static_b3sum', type: 'boolean', value: false, description: 'Build statically linked b3sum executable')" >> meson_options.txt

    sed -i "s/VERSION/${PV}/g" "${S}/b3sum.c" || die "Failed to replace VERSION in b3sum.c"
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
	insinto /usr/include
	doins blake3.h

    meson_src_install

    dobin dedup_symlink
}
