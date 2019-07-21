# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIM_VERSION="8.0"

inherit vim-doc flag-o-matic python-single-r1 git-r3

DESCRIPTION="Vim, an improved vi-style text editor"
HOMEPAGE="https://vim.sourceforge.io/ https://github.com/vim/vim"
EGIT_REPO_URI="https://github.com/vim/vim.git"

SLOT="0"
LICENSE="vim"
KEYWORDS="amd64 arm64"

IUSE="acl cscope debug gpm nls python racket terminal vim-pager"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

RDEPEND="
	>=lib-sys/ncurses-5.2-r2:0=
	nls? ( sys-devel/gettext )
	acl? ( sys-app/acl )
	cscope? ( dev-util/cscope )
	gpm? ( >=lib-sys/gpm-1.19.3 )
	python? ( ${PYTHON_DEPS} )
"

DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	nls? ( sys-devel/gettext )
"

pkg_setup() {
	unset LANG LC_ALL
	export LC_COLLATE="C"

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# Fixup a script to use awk instead of nawk
	sed -i -e \
		'1s|.*|#!'"${EPREFIX}"'/usr/bin/awk -f|' \
		"${S}"/runtime/tools/mve.awk || die "mve.awk sed failed"

	# Read vimrc and gvimrc from /etc/vim
	echo '#define SYS_VIMRC_FILE "'${EPREFIX}'/etc/vim/vimrc"' \
		>> "${S}"/src/feature.h || die "echo failed"
	echo '#define SYS_GVIMRC_FILE "'${EPREFIX}'/etc/vim/gvimrc"' \
		>> "${S}"/src/feature.h || die "echo failed"

	# Use exuberant ctags which installs as /usr/bin/exuberant-ctags.
	# Hopefully this pattern won't break for a while at least.
	# This fixes bug 29398 (27 Sep 2003 agriffis)
	sed -i -e \
		's/\<ctags\("\| [-*.]\)/exuberant-&/g' \
		"${S}"/runtime/doc/syntax.txt \
		"${S}"/runtime/doc/tagsrch.txt \
		"${S}"/runtime/doc/usr_29.txt \
		"${S}"/runtime/menu.vim \
		"${S}"/src/configure.ac || die 'sed failed'

	# Don't be fooled by /usr/include/libc.h.  When found, vim thinks
	# this is NeXT, but it's actually just a file in lib-dev/9libs
	# This fixes bug 43885 (20 Mar 2004 agriffis)
	sed -i -e \
		's/ libc\.h / /' \
		"${S}"/src/configure.ac || die 'sed failed'

	# gcc on sparc32 has this, uhm, interesting problem with detecting EOF
	# correctly. To avoid some really entertaining error messages about stuff
	# which isn't even in the source file being invalid, we'll do some trickery
	# to make the error never occur. bug 66162 (02 October 2004 ciaranm)
	find "${S}" -name '*.c' | while read c; do
	    echo >> "$c" || die "echo failed"
	done

	# conditionally make the manpager.sh script
	if use vim-pager; then
		cat > "${S}"/runtime/macros/manpager.sh <<-_EOF_ || die "cat EOF failed"
			#!/bin/sh
			sed -e 's/\x1B\[[[:digit:]]\+m//g' | col -b | \\
					vim \\
						-c 'let no_plugin_maps = 1' \\
						-c 'set nolist nomod ft=man ts=8' \\
						-c 'let g:showmarks_enable=0' \\
						-c 'runtime! macros/less.vim' -
			_EOF_
	fi

	# Try to avoid sandbox problems. Bug #114475.
	if [[ -d "${S}"/src/po ]]; then
		sed -i -e \
			'/-S check.vim/s,..VIM.,ln -s $(VIM) testvim \; ./testvim -X,' \
			"${S}"/src/po/Makefile || die "sed failed"
	fi

	cp -v "${S}"/src/config.mk.dist "${S}"/src/auto/config.mk || die "cp failed"

	sed -i -e \
		"s:\\\$(PERLLIB)/ExtUtils/xsubpp:${EPREFIX}/usr/bin/xsubpp:" \
		"${S}"/src/Makefile || die 'sed for ExtUtils-ParseXS failed'

	eapply_user
}

src_configure() {
	local myconf=()

	# Fix bug 18245: Prevent "make" from the following chain:
	# (1) Notice configure.ac is newer than auto/configure
	# (2) Rebuild auto/configure
	# (3) Notice auto/configure is newer than auto/config.mk
	# (4) Run ./configure (with wrong args) to remake auto/config.mk
	sed -i 's# auto/config\.mk:#:#' src/Makefile || die "Makefile sed failed"
	rm src/auto/configure || die "rm failed"
	emake -j1 -C src autoconf

	# This should fix a sandbox violation (see bug 24447).
	for file in /dev/pty/s* /dev/console; do
		if [[ -e "${file}" ]]; then
			addwrite $file
		fi
	done

	myconf=(
			--with-features=tiny
			--enable-nls
			--disable-acl
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

	econf \
		"${myconf[@]}"
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

	if use vim-pager ; then
		dosym ${vimfiles}/macros/less.sh /usr/bin/vimpager
		dosym ${vimfiles}/macros/manpager.sh /usr/bin/vimmanpager
		insinto ${vimfiles}/macros
		doins runtime/macros/manpager.sh
		fperms a+x ${vimfiles}/macros/manpager.sh
	fi
}

pkg_postinst() {
	# Update documentation tags (from vim-doc.eclass)
	update_vim_helptags
}

pkg_postrm() {
	# Update documentation tags (from vim-doc.eclass)
	update_vim_helptags
}
