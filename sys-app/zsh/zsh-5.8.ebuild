# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic prefix

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/zsh/code"
else
	SRC_URI="https://www.zsh.org/pub/${P}.tar.xz
		https://www.zsh.org/pub/old/${P}.tar.xz
		mirror://sourceforge/${PN}/${P}.tar.xz"
fi

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="https://www.zsh.org/"

LICENSE="ZSH gdbm? ( GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gdbm static"

RDEPEND="
	lib-sys/ncurses:0=
	static? ( lib-sys/ncurses:0=[static-libs]
				lib-dev/libpcre:0=[static-libs] )
	lib-sys/libcap
	lib-dev/libpcre
	gdbm? ( lib-sys/gdbm:= )
"
DEPEND="sys-app/groff
	${RDEPEND}"

filter-flags -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-etcdir="${EPREFIX}"/etc/zsh
		--enable-zshenv="${EPREFIX}"/etc/zsh/zshenv
		--enable-zlogin="${EPREFIX}"/etc/zsh/zlogin
		--enable-zlogout="${EPREFIX}"/etc/zsh/zlogout
		--enable-zprofile="${EPREFIX}"/etc/zsh/zprofile
		--enable-zshrc="${EPREFIX}"/etc/zsh/zshrc
		--enable-maildir-support
		--enable-multibyte
		--enable-function-subdirs
		--enable-fndir="${EPREFIX}"/usr/share/zsh/functions
		--enable-scriptdir="${EPREFIX}"/usr/share/zsh/scripts
		--with-tcsetpgrp
		--enable-pcre
		--enable-cap
		--enable-zsh-secure-free
		$(use_enable gdbm)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

	if use static ; then
		# compile all modules statically, see Bug #27392
		# removed cap and curses because linking failes
		sed -e "s,link=no,link=static,g" \
			-e "/^name=zsh\/cap/s,link=static,link=no," \
			-e "/^name=zsh\/curses/s,link=static,link=no," \
			-i "${S}"/config.modules || die
		if ! use gdbm ; then
			sed -i '/^name=zsh\/db\/gdbm/s,link=static,link=no,' \
				"${S}"/config.modules || die
		fi
	fi
}
