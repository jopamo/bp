# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.sv.gnu.org/nano.git"
	inherit git-r3 autotools
else
	SRC_URI="https://www.nano-editor.org/dist/v4/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="https://www.nano-editor.org/ https://wiki.gentoo.org/wiki/Nano/Basics_Guide"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug justify +magic minimal nls static"

LIB_DEPEND="lib-sys/ncurses
	lib-sys/ncurses:0=[static-libs(+)]
	magic? ( sys-app/file[static-libs(+)] )
	nls? ( sys-devel/gettext )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	static? ( ${LIB_DEPEND} )"

src_prepare() {
	default
	if [[ ${PV} == "9999" ]] ; then
		eautoreconf
	fi
}

src_configure() {
	use static && append-ldflags -static
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
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
		$(use_enable magic libmagic)
		$(use_enable justify)
		$(use_enable debug)
		$(use_enable nls)
		$(use_enable minimal tiny)
	)
	case ${CHOST} in
		*-gnu*|*-uclibc*) myconf+=( "--with-wordbounds" ) ;; #467848
	esac
	econf "${myconf[@]}"
}

src_install() {
	default

	rm -rf "${ED}"/usr/share/doc

	insinto /etc
	newins doc/sample.nanorc nanorc

	if ! use minimal ; then
		# Enable colorization by default.
		sed -i \
			-e '/^# include /s:# *::' \
			"${ED%/}"/etc/nanorc || die
	fi
}
