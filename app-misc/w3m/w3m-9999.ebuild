# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools flag-o-matic eutils prefix git-r3

DESCRIPTION="Text based WWW browser, supports tables and frames"
HOMEPAGE="https://github.com/tats/w3m"
EGIT_REPO_URI="https://github.com/tats/w3m.git"
KEYWORDS="amd64 arm64"

LICENSE="w3m"
SLOT="0"
IUSE="X fbcon gpm imlib libressl lynxkeymap nls nntp ssl unicode xface"

RDEPEND=">=lib-sys/ncurses-5.2-r3:0=
	>=lib-sys/zlib-1.1.3-r2
	lib-dev/boehm-gc
	X? ( x11-libs/libXext x11-libs/libXdmcp )
	imlib? ( >=lib-media/imlib2-1.1.0[X] )
	xface? ( lib-media/compface )
	gpm? ( >=lib-sys/gpm-1.19.3-r5 )
	ssl? (
		!libressl? ( lib-dev/openssl:0= )
		libressl? ( lib-dev/libressl:0= )
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	default
	sed -i -e "/^AR=/s:ar:$(tc-getAR):" {.,w3mimg,libwc}/Makefile.in || die
	hprefixify acinclude.m4
	eautoconf
}

src_configure() {
	append-flags -fno-strict-aliasing
	local myconf imagelibval imageval

	if use imlib ; then
		imagelibval="imlib2"
	fi

	if [ ! -z "${imagelibval}" ] ; then
		use X && imageval="${imageval}${imageval:+,}x11"
		use X && use fbcon && imageval="${imageval}${imageval:+,}fb"
	fi

	if use unicode ; then
		myconf="${myconf} --with-charset=UTF-8"
	else
		myconf="${myconf} --with-charset=US-ASCII"
	fi

	myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-editor="${EPREFIX}/usr/bin/vi"
		--with-mailer="${EPREFIX}/bin/mail"
		--with-browser="${EPREFIX}/usr/bin/xdg-open"
		--with-termlib=yes
		--enable-image=${imageval:-no}
		--with-imagelib="${imagelibval:-no}"
		--without-migemo
		--enable-m17n
		--enable-keymap=w3m
		--enable-unicode
		$(use_enable gpm mouse)
		$(use_enable nls)
		$(use_enable nntp)
		$(use_enable ssl digest-auth)
		$(use_with ssl)
		$(use_enable xface)
		${myconf}
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /etc/${PN}
	newins "${FILESDIR}/${PN}.mailcap" mailcap
}
