# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools python-r1

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xcbproto.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	lib-core/libxml2"

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
