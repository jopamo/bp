# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-r1

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=faa9c89eb32e2a60ec542fe09a53fb40f0c1c5a2
SRC_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/${SNAPSHOT}/xcbproto-${SNAPSHOT}.tar.bz2 -> xcbproto-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xcbproto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/libxml2"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	PYTHON=python3 default
}

src_compile() {
	:
}

xcbgen_install() {
	emake -C xcbgen install DESTDIR="${D}" pythondir="$(python_get_sitedir)"
	python_optimize
}

src_install() {
	emake install DESTDIR="${D}" SUBDIRS=src
	python_foreach_impl xcbgen_install
}
