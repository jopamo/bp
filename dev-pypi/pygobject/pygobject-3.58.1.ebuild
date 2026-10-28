# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 pypi

# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND="
	>=dev-pypi/pycairo-1.16[${PYTHON_USEDEP}]
"
# lockstep-pypi-deps: end

DESCRIPTION="Python bindings for GObject Introspection"
HOMEPAGE="https://pygobject.gnome.org/"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND+="
	>=lib-core/glib-2.80[introspection]
	>=lib-core/libffi-3.0
	xgui-lib/cairo[glib]
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
	>=dev-pypi/pycairo-1.16[${PYTHON_USEDEP}]
	test? (
		dev-pypi/pytest[${PYTHON_USEDEP}]
		>=lib-dev/gobject-introspection-1.64
	)
"

PATCHES=(
	"${FILESDIR}/0001-marshal-explicit-callback-errors.patch"
	"${FILESDIR}/0002-release-unconverted-caller-outputs.patch"
	"${FILESDIR}/0003-release-copied-byte-outputs.patch"
	"${FILESDIR}/0004-release-copied-scalar-outputs.patch"
	"${FILESDIR}/0005-release-skipped-caller-outputs.patch"
	"${FILESDIR}/0006-release-transfer-none-string-outputs.patch"
	"${FILESDIR}/0007-preserve-container-transfer-string-elements.patch"
	"${FILESDIR}/0008-release-full-transfer-c-strings.patch"
	"${FILESDIR}/0009-release-full-transfer-glib-strings-once.patch"
	"${FILESDIR}/0010-own-copied-caller-allocated-records.patch"
	"${FILESDIR}/0011-preserve-borrowed-containers-on-failure.patch"
	"${FILESDIR}/0012-retain-failed-results-through-cleanup.patch"
	"${FILESDIR}/0013-release-caller-allocated-boxed-arrays.patch"
)

src_prepare() {
	distutils-r1_src_prepare
	cp "${FILESDIR}"/byte-output.{c,h,py} tests/ || die
	cat "${FILESDIR}/byte-output.meson" >> tests/meson.build || die
}

python_configure_all() {
	DISTUTILS_ARGS=(
		-Dpycairo=enabled
		-Dtests=$(usex test true false)
	)
}

python_test() {
	meson_src_test
}
