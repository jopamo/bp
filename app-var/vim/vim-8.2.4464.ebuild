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

IUSE="acl debug huge libsodium +xxd"

DEPEND="
	virtual/curses
	acl? ( app-core/acl )
	libsodium? ( lib-live/libsodium )
"
BDEPEND="
	app-build/autoconf
	app-build/gettext
"

src_configure() {
	use debug && append-flags "-DDEBUG"

	# let package manager strip binaries
	export ac_cv_prog_STRIP="$(type -P true ) faking strip"

	local tiny=(
		--prefix="${EPREFIX}"/usr
		--localstatedir="${EPREFIX}"/var/lib/vim
		--with-features=tiny
		$(use_enable acl)
		$(use_enable libsodium)
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

	local huge=(
		--prefix="${EPREFIX}"/usr
		--localstatedir="${EPREFIX}"/var/lib/vim
		--with-features=huge
		$(use_enable acl)
		$(use_enable libsodium)
		--disable-canberra
		--disable-gui
		--enable-cscope
		--enable-gpm
		--enable-gui=no
		--enable-luainterp=dynamic
		--enable-multibyte
		--enable-netbeans
		--enable-perlinterp=dynamic
		--enable-python3interp=dynamic
		--enable-rubyinterp=dynamic
		--enable-tclinterp=dynamic
		--without-x
	)

	use huge || ECONF_SOURCE=${S} econf "${tiny[@]}"
	use huge && ECONF_SOURCE=${S} econf "${huge[@]}"
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
	if ! use huge ; then
		dobin src/vim
		doman runtime/doc/vim.1

		for i in vimdiff rvim rview vi ex view ; do
			dosym vim usr/bin/$i
		done

		if use xxd ; then
			dobin src/xxd/xxd
			doman runtime/doc/xxd.1
		fi

		insopts -m 0644
		insinto /usr/share/vim/vim82
		doins runtime/defaults.vim
	else
		default
		rm -r "${ED}"/usr/share/icons || die
		rm -r "${ED}"/usr/share/man/{da*,it*,pl*,tr*} || die
	fi

	insopts -m 0644
	insinto /etc
	newins "${FILESDIR}"/basic.vim vimrc
}
