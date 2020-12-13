# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3

DESCRIPTION="Text based WWW browser, supports tables and frames"
HOMEPAGE="https://github.com/tats/w3m"
EGIT_REPO_URI="https://github.com/tats/w3m.git"

LICENSE="w3m"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X gpm imlib nls nntp ssl unicode"

DEPEND=">=lib-sys/ncurses-5.2-r3:0=
	>=lib-sys/zlib-1.1.3-r2
	lib-dev/boehm-gc
	X? ( x11-libs/libXext x11-libs/libXdmcp )
	imlib? ( >=lib-media/imlib2-1.1.0[X] )
	gpm? ( >=lib-sys/gpm-1.19.3-r5 )
	ssl? ( virtual/ssl )
"

src_configure() {
	append-flags -fno-strict-aliasing

	local myconf=(
		--with-termlib=yes
		--without-migemo
		--enable-m17n
		--enable-keymap=w3m
		--disable-w3mmailer
		$(use_enable gpm mouse)
		$(use_enable nls)
		$(use_enable nntp)
		$(use_enable ssl digest-auth)
		$(use_with ssl)
		$(usex unicode "--with-charset=UTF-8" "--with-charset=US-ASCII")
		$(use_enable unicode)
		$(usex X "--enable-image=x11,fb" "")
		$(usex imlib "--with-imagelib=imlib2" "")
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
