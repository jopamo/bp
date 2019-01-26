# Distributed under the terms of the GNU General Public License v2

EAPI=6
VIM_VERSION="8.0"
inherit estack vim-doc flag-o-matic versionator

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vim/vim.git"
	EGIT_CHECKOUT_DIR=${WORKDIR}/vim-${PV}
else
	SRC_URI="https://github.com/vim/vim/archive/v${PV}.tar.gz -> vim-${PV}.tar.gz"
fi

DESCRIPTION="vim and gvim shared files"
HOMEPAGE="https://vim.sourceforge.io/ https://github.com/vim/vim"
KEYWORDS="amd64 arm64 x86"

SLOT="0"
LICENSE="vim"
IUSE="nls acl +minimal"

DEPEND="sys-devel/autoconf"

S=${WORKDIR}/vim-${PV}

pkg_setup() {
	# people with broken alphabets run into trouble. bug 82186.
	unset LANG LC_ALL
	export LC_COLLATE="C"

	# Gnome sandbox silliness. bug #114475.
	mkdir -p "${T}"/home || die "mkdir -p failed"
	export HOME="${T}"/home
}

src_prepare() {
	# Fixup a script to use awk instead of nawk
	sed -i \
		-e '1s|.*|#!'"${EPREFIX}"'/usr/bin/awk -f|' \
		"${S}"/runtime/tools/mve.awk || die "sed failed"

	# See #77841. We remove this file after the tarball extraction.
	rm -v "${S}"/runtime/tools/vimspell.sh || die "rm failed"

	# Read vimrc and gvimrc from /etc/vim
	echo '#define SYS_VIMRC_FILE "'${EPREFIX}'/etc/vim/vimrc"' >> "${S}"/src/feature.h
	echo '#define SYS_GVIMRC_FILE "'${EPREFIX}'/etc/vim/gvimrc"' >> "${S}"/src/feature.h

	# Use exuberant ctags which installs as /usr/bin/exuberant-ctags.
	# Hopefully this pattern won't break for a while at least.
	# This fixes bug 29398 (27 Sep 2003 agriffis)
	sed -i 's/\<ctags\("\| [-*.]\)/exuberant-&/g' \
		"${S}"/runtime/doc/syntax.txt \
		"${S}"/runtime/doc/tagsrch.txt \
		"${S}"/runtime/doc/usr_29.txt \
		"${S}"/runtime/menu.vim \
		"${S}"/src/configure.ac || die 'sed failed'

	# Don't be fooled by /usr/include/libc.h.  When found, vim thinks
	# this is NeXT, but it's actually just a file in lib-dev/9libs
	# This fixes bug 43885 (20 Mar 2004 agriffis)
	sed -i 's/ libc\.h / /' "${S}"/src/configure.ac || die 'sed failed'

	# gcc on sparc32 has this, uhm, interesting problem with detecting EOF
	# correctly. To avoid some really entertaining error messages about stuff
	# which isn't even in the source file being invalid, we'll do some trickery
	# to make the error never occur. bug 66162 (02 October 2004 ciaranm)
	find "${S}" -name '*.c' | while read c; do
	    echo >> "$c" || die "echo failed"
	done

	# Try to avoid sandbox problems. Bug #114475.
	if [[ -d "${S}"/src/po ]]; then
		sed -i -e \
			'/-S check.vim/s,..VIM.,ln -s $(VIM) testvim \; ./testvim -X,' \
			"${S}"/src/po/Makefile || die "sed failed"
	fi

	cp -v "${S}"/src/config.mk.dist "${S}"/src/auto/config.mk || die "cp failed"

	# Bug #378107 - Build properly with >=perl-core/ExtUtils-ParseXS-3.20.0
	sed -i -e \
		"s:\\\$(PERLLIB)/ExtUtils/xsubpp:${EPREFIX}/usr/bin/xsubpp:" \
		"${S}"/src/Makefile || die 'sed for ExtUtils-ParseXS failed'

	eapply_user
}

src_configure() {
	local myconf

	# Fix bug 37354: Disallow -funroll-all-loops on amd64
	# Bug 57859 suggests that we want to do this for all archs
	filter-flags -funroll-all-loops

	# Fix bug 76331: -O3 causes problems, use -O2 instead. We'll do this for
	# everyone since previous flag filtering bugs have turned out to affect
	# multiple archs...
	replace-flags -O3 -O2

	# Fix bug 18245: Prevent "make" from the following chain:
	# (1) Notice configure.ac is newer than auto/configure
	# (2) Rebuild auto/configure
	# (3) Notice auto/configure is newer than auto/config.mk
	# (4) Run ./configure (with wrong args) to remake auto/config.mk
	sed -i 's# auto/config\.mk:#:#' src/Makefile || die "Makefile sed failed"

	# Remove src/auto/configure file.
	rm -v src/auto/configure || die "rm configure failed"

	emake -j1 -C src autoconf

	# This should fix a sandbox violation (see bug 24447).
	for file in /dev/pty/s* /dev/console ; do
		if [[ -e "${file}" ]]; then
			addwrite $file
		fi
	done

	# Let Portage do the stripping. Some people like that.
	export ac_cv_prog_STRIP="$(type -P true ) faking strip"

	econf \
		--enable-gui=no \
		--without-x \
		--disable-darwin \
		--disable-perlinterp \
		--disable-pythoninterp \
		--disable-rubyinterp \
		--disable-gpm \
		--disable-selinux \
		$(use_enable nls) \
		$(use_enable acl) \
		${myconf}
}

src_compile() {
	emake -j1 -C src auto/osdef.h objects
	emake tools
}

src_test() { :; }

src_install() {
	local vimfiles=/usr/share/vim/vim${VIM_VERSION/.}

	dodir /usr/{bin,share/{man/man1,vim}}
	emake -C src \
		installruntime \
		installmanlinks \
		installmacros \
		installtutor \
		installtutorbin \
		installtools \
		install-languages \
		DESTDIR="${D}" \
		BINDIR="${EPREFIX}"/usr/bin \
		MANDIR="${EPREFIX}"/usr/share/man \
		DATADIR="${EPREFIX}"/usr/share

	keepdir ${vimfiles}/keymap

	# default vimrc is installed by vim-core since it applies to
	# both vim and gvim
	insinto /etc/vim/
	newins "${FILESDIR}"/vimrc-r5 vimrc

	if use minimal; then
		# To save space, install only a subset of the files.
		# Helps minimalize the livecd, bug 65144.
		eshopts_push -s extglob

		rm -v "${ED}"/usr/bin/vimtutor || die "rm failed"

		local keep_colors="default"
		ignore=$(rm -fr "${ED}${vimfiles}"/colors/!(${keep_colors}).vim )

		local keep_syntax="conf|crontab|fstab|inittab|resolv|sshdconfig"
		# tinkering with the next line might make bad things happen ...
		keep_syntax="${keep_syntax}|syntax|nosyntax|synload"
		ignore=$(rm -fr "${ED}${vimfiles}"/syntax/!(${keep_syntax}).vim )

		eshopts_pop
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
