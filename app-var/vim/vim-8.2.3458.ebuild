# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Vim, an improved vi-style text editor"
HOMEPAGE="https://vim.sourceforge.io/ https://github.com/vim/vim"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/vim/vim"
	inherit git-r3
else
	SRC_URI="https://github.com/vim/vim/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="vim"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +xxd"

DEPEND="
	virtual/curses
	app-core/acl
"

BDEPEND="
	app-build/autoconf
	app-build/gettext
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

	use xxd && emake src/xxd
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

	for i in vimdiff rvim rview vi ex view ; do
		dosym vim usr/bin/$i
	done

	use xxd && dobin src/xxd/xxd
}
