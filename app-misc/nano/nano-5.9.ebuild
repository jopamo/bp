# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="https://www.nano-editor.org/ https://wiki.gentoo.org/wiki/Nano/Basics_Guide"
SRC_URI="https://www.nano-editor.org/dist/v$(ver_cut 1)/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+color debug +magic +multibuffer +nanorc static"

LIB_DEPEND="
	virtual/curses[static-libs(+)]
	magic? ( app-core/file[static-libs(+)] )
"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
"

src_configure() {
	use static && append-ldflags -static
	local myconf=(
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
		--disable-nls
		$(use_enable color)
		$(use_enable multibuffer)
		$(use_enable nanorc)
		$(use_enable magic libmagic)
		$(use_enable debug)
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc
	newins doc/sample.nanorc nanorc

	# Enable colorization by default.
	sed -i \
		-e '/^# include /s:# *::' \
		"${ED%/}"/etc/nanorc || die
}
