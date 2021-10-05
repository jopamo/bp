# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-r1

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=151ee69847c706e2b9d38c82e20534910f140b55
	SRC_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/${SNAPSHOT}/xcbproto-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
	S=${WORKDIR}/xcbproto-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
else
	SRC_URI=""
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/libxml2"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# Don't use Python to find sitedir here.
	PYTHON=true default
}

src_compile() {
	:
}

xcbgen_install() {
	# Use eclass to find sitedir instead.
	emake -C xcbgen install DESTDIR="${D}" pythondir="$(python_get_sitedir)"
	python_optimize
}

src_install() {
	# Restrict SUBDIRS to prevent xcbgen with empty sitedir.
	emake install DESTDIR="${D}" SUBDIRS=src
	python_foreach_impl xcbgen_install
}
