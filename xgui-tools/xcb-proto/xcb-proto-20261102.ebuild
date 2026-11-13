# Distributed under the terms of the GNU General Public License v2

inherit autotools python-r1

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=dea37a7033abfdef3376dc9ad5e8756e9fee959b
SRC_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/${SNAPSHOT}/xcbproto-${SNAPSHOT}.tar.bz2 -> xcbproto-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xcbproto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="lib-core/libxml2"
RDEPEND="${PYTHON_DEPS}"
BDEPEND="${PYTHON_DEPS}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	python_setup
	default
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
