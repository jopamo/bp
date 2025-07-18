# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Library for Large Linear Classification"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/liblinear/ https://github.com/cjlin1/liblinear"
SNAPSHOT=dbb92699c33b37d0217d8d8b34d72c1ff4176437
SRC_URI="https://github.com/cjlin1/liblinear/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
SONAME="5"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	cp "${FILESDIR}/meson.build" "${S}/" || die "Failed to copy meson.build"

	echo "option('build_static_lib', type: 'boolean', value: false, description: 'Enable or disable building the static BLAS library')" > meson_options.txt
}

src_install() {
	meson_src_install

	insinto /usr/include
	doins linear.h newton.h

}

