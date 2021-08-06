# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit python-single-r1 toolchain-funcs xdg-utils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/kovidgoyal/kitty.git"
	inherit git-r3
else
	SRC_URI="https://github.com/kovidgoyal/kitty/releases/download/v${PV}/${P}.tar.xz"
fi

DESCRIPTION="A modern, hackable, featureful, OpenGL-based terminal emulator"
HOMEPAGE="https://github.com/kovidgoyal/kitty"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug wayland"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.21.2-flags.patch
	"${FILESDIR}"/${PN}-0.21.2-remove-terminfo.patch
	"${FILESDIR}"/${PN}-0.20.1-tests.patch
)

src_prepare() {
	default

	# disable wayland as required
	if ! use wayland; then
		sed -i "/'x11 wayland'/s/ wayland//" setup.py || die
		# also disable wayland tests
		sed -i "/if not self.is_ci/d" kitty_tests/check_build.py || die
		sed -i "/linux_backends.append('wayland')/d" kitty_tests/check_build.py || die
	fi

	# respect doc dir
	sed -i "/htmldir =/s/appname/'${PF}'/" setup.py || die

	tc-export CC
}

src_compile() {
	"${EPYTHON}" setup.py \
		--verbose $(usex debug --debug "") \
		--libdir-name lib \
		--update-check-interval=0 \
		linux-package || die "Failed to compile kitty."
}

src_test() {
	export KITTY_CONFIG_DIRECTORY=${T}
	"${EPYTHON}" test.py || die
}

src_install() {
	insinto /usr
	doins -r linux-package/*
	dobin linux-package/bin/kitty
	python_fix_shebang "${ED}"
}

pkg_postinst() {
	xdg_icon_cache_update
	optfeature "Displaying images in the terminal" virtual/imagemagick-tools
}

pkg_postrm() {
	xdg_icon_cache_update
}
