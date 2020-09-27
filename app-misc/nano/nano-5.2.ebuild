# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="https://www.nano-editor.org/ https://wiki.gentoo.org/wiki/Nano/Basics_Guide"
SRC_URI="https://www.nano-editor.org/dist/v$(ver_cut 1)/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug justify +magic minimal nls static"

LIB_DEPEND="lib-sys/ncurses
	lib-sys/ncurses:0=[static-libs(+)]
	magic? ( sys-app/file[static-libs(+)] )
	nls? ( sys-devel/gettext )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	static? ( ${LIB_DEPEND} )"

src_configure() {
	use static && append-ldflags -static
	local myconf=(
		--without-slang
		--disable-wrapping
		--enable-utf8
		--disable-speller
		--disable-wordcomp
		--disable-tabcomp
		--disable-justify
		--disable-histories
		--disable-help
		--disable-extra
		--disable-browser
		--disable-comment
		$(use_enable !minimal color)
		$(use_enable !minimal multibuffer)
		$(use_enable !minimal nanorc)
		$(use_enable minimal tiny)
		$(use_enable magic libmagic)
		$(use_enable justify)
		$(use_enable debug)
		$(use_enable nls)
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	if ! use minimal ; then
		insinto /etc
		newins doc/sample.nanorc nanorc

		# Enable colorization by default.
		sed -i \
			-e '/^# include /s:# *::' \
			"${ED%/}"/etc/nanorc || die
	fi
}
