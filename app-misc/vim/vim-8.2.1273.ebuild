# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Vim, an improved vi-style text editor"
HOMEPAGE="https://vim.sourceforge.io/ https://github.com/vim/vim"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/vim/vim"
	inherit git-r3
else
	SNAPSHOT=c69950ac17225d07f973b39d5b0eb94291077808
	SRC_URI="https://github.com/vim/vim/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="vim"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

RDEPEND="
	>=lib-sys/ncurses-5.2-r2:0=
	sys-devel/gettext
	sys-app/acl
"

DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/gettext
"

src_configure() {
	local myconf=(
		--with-features=tiny
		--enable-nls
		--enable-acl
		--enable-gui=no
		--without-x
		--disable-darwin
		--disable-luainterp
		--disable-perlinterp
		--disable-pythoninterp
		--disable-mzschemeinterp
		--disable-rubyinterp
		--disable-selinux
		--disable-tclinterp
		--disable-gpm
		)

	use debug && append-flags "-DDEBUG"

	# let package manager strip binaries
	export ac_cv_prog_STRIP="$(type -P true ) faking strip"

	# keep prefix env contained within the EPREFIX
	use prefix && myconf+=( --without-local-dir )

	econf "${myconf[@]}"
}

src_compile() {
	# The following allows emake to be used
	emake -j1 -C src auto/osdef.h objects

	emake
}

src_test() {
	einfo
	einfo "Starting vim tests. Several error messages will be shown"
	einfo "while the tests run. This is normal behaviour and does not"
	einfo "indicate a fault."
	einfo
	ewarn "If the tests fail, your terminal may be left in a strange"
	ewarn "state. Usually, running 'reset' will fix this."
	einfo

	# Don't let vim talk to X
	unset DISPLAY

	emake -j1 -C src/testdir nongui
}

src_install() {
	local vimfiles=/usr/share/vim/vim${VIM_VERSION/.}

	dobin src/vim
	dosym vim /usr/bin/vimdiff
	dosym vim /usr/bin/rvim
	dosym vim /usr/bin/rview
	dosym vim /usr/bin/vi
	dosym vim /usr/bin/ex
	dosym vim /usr/bin/view
}
