# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools libtool toolchain-funcs git-r3

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"
EGIT_REPO_URI="https://gitlab.freedesktop.org/wayland/wayland.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs dtd-validation"

BDEPEND="
	dev-util/pkgconf
	doc? (
		>=app-text/doxygen-1.6[dot]
		app-text/xmlto
		>=app-media/graphviz-2.26.0
		sys-app/grep[pcre]
	)
"
DEPEND="
	lib-dev/expat
	lib-dev/libxml2
	lib-dev/libffi
"
RDEPEND="${DEPEND}
	!<lib-media/mesa-18.1.1-r1
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-static
		$(use_enable doc documentation)
		$(use_enable dtd-validation)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_test() {
	# We set it on purpose to only a short subdir name, as socket paths are
	# created in there, which are 108 byte limited. With this it hopefully
	# barely fits to the limit with /var/tmp/portage/$CAT/$PF/temp/xdr
	export XDG_RUNTIME_DIR="${T}"/xdr
	mkdir "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	src_test
}
