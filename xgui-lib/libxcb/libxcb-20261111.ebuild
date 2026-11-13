# Distributed under the terms of the GNU General Public License v2

inherit autotools python-any-r1 qa-policy

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=aa7f3256060451ad65a38feeccf792f44181a4e0
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/${SNAPSHOT}/libxcb-${SNAPSHOT}.tar.bz2 -> libxcb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la test xkb static-libs"

DEPEND="
	xgui-lib/libXau
	xgui-lib/libXdmcp
	test? ( lib-dev/check )
	lib-core/libxslt
"
BDEPEND="$(python_gen_any_dep 'xgui-tools/xcb-proto[${PYTHON_USEDEP}]')"

python_check_deps() {
	python_has_version "xgui-tools/xcb-proto[${PYTHON_USEDEP}]"
}

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	qa-policy-configure
	local myconf=(
		--disable-devel-docs
		$(use_enable xkb)
		--enable-xinput
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
