# Distributed under the terms of the GNU General Public License v2

EAPI=8

SHORTNM="usr/share/vim/vim91"

inherit flag-o-matic

DESCRIPTION="Vim, an improved vi-style text editor"
HOMEPAGE="https://vim.sourceforge.io/ https://github.com/vim/vim"
SNAPSHOT=adc729cd32671c6a3bc6cbb3f0a64a984d454f01
SRC_URI="https://github.com/vim/vim/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="vim"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl debug normal xxd"

DEPEND="
	virtual/curses
	acl? ( app-core/acl )
"
BDEPEND="
	app-build/autoconf
	app-build/gettext
"

src_prepare() {
	default
	cat "${FILESDIR}"/basic.vim > "${T}"/new.vim
}

src_configure() {
	use debug && append-flags "-DDEBUG"

	# let package manager strip binaries
	export ac_cv_prog_STRIP="$(type -P true ) faking strip"

	local tiny=(
		--prefix="${EPREFIX}"/usr
		--localstatedir="${EPREFIX}"/var/lib/vim
		--with-features=tiny
		$(use_enable acl)
		--disable-canberra
		--disable-darwin
		--disable-gpm
		--disable-gui
		--disable-luainterp
		--disable-mzschemeinterp
		--disable-nls
		--disable-perlinterp
		--disable-pythoninterp
		--disable-rubyinterp
		--disable-selinux
		--disable-tclinterp
		--without-x
	)

	local normal=(
		--prefix="${EPREFIX}"/usr
		--localstatedir="${EPREFIX}"/var/lib/vim
		--with-features=normal
		$(use_enable acl)
		--disable-canberra
		--disable-cscope
		--disable-gpm
		--disable-gui
		--disable-luainterp
		--disable-mzschemeinterp
		--disable-netbeans
		--disable-nls
		--disable-perlinterp
		--disable-pythoninterp
		--disable-rubyinterp
		--disable-selinux
		--disable-tclinterp
		--enable-gui=no
		--without-x
	)

	use normal || ECONF_SOURCE=${S} econf "${tiny[@]}"
	use normal && ECONF_SOURCE=${S} econf "${normal[@]}"
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
	if ! use normal ; then
		dobin src/vim
		doman runtime/doc/vim.1

		for i in vimdiff rvim rview vi ex view ; do
			dosym vim usr/bin/$i
		done

		if use xxd ; then
			dobin src/xxd/xxd
			doman runtime/doc/xxd.1
		fi
	else
		default
		rm -r "${ED}"/usr/share/{applications,icons} || die
		cat "${FILESDIR}"/colors.vim >> "${T}"/new.vim || die
	fi

	insinto /${SHORTNM}/
	newins "${T}/new.vim" defaults.vim
}
