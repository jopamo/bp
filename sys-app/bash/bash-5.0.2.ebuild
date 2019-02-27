# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs prefix

DESCRIPTION="The standard GNU Bourne again shell"
HOMEPAGE="http://tiswww.case.edu/php/chet/bash/bashtop.html"
SRC_URI="http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
		http://ftp.gnu.org/gnu/bash/bash-5.0-patches/bash50-001
		http://ftp.gnu.org/gnu/bash/bash-5.0-patches/bash50-002"

S=${WORKDIR}/${PN}-5.0

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="afs bashlogger examples mem-scramble +net nls plugins"

DEPEND="
	>=lib-sys/ncurses-5.2-r2:0=
	lib-sys/readline
	nls? ( sys-devel/gettext )"

PATCHES=( ${DISTDIR}/bash50-001
			${DISTDIR}/bash50-002	)


pkg_setup() {
	if is-flag -malign-double ; then #7332
		eerror "Detected bad CFLAGS '-malign-double'.  Do not use this"
		eerror "as it breaks LFS (struct stat64) on x86."
		die "remove -malign-double from your CFLAGS mr ricer"
	fi
	if use bashlogger ; then
		ewarn "The logging patch should ONLY be used in restricted (i.e. honeypot) envs."
		ewarn "This will log ALL output you enter into the shell, you have been warned."
	fi
}


src_prepare() {
	cd ../
	default
	cd ${S}

	# Prefixify hardcoded path names. No-op for non-prefix.
	hprefixify pathnames.h.in

	# Avoid regenerating docs after patches #407985
	sed -i -r '/^(HS|RL)USER/s:=.*:=:' doc/Makefile.in || die
	touch -r . doc/*

	eapply_user
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--disable-profiling
		--docdir='$(datarootdir)'/doc/${PF}
		--htmldir='$(docdir)/html'
		--with-curses
		$(use_enable mem-scramble)
		$(use_enable net net-redirections)
		--enable-readline
		--enable-bang-history
		--enable-history
		$(use_with afs)
		$(use_with mem-scramble bash-malloc)
		$(use_enable nls)
	)

	# For descriptions of these, see config-top.h
	# bashrc/#26952 bash_logout/#90488 ssh/#24762 mktemp/#574426
	append-cppflags \
		-DDEFAULT_PATH_VALUE=\'\"${EPREFIX}/usr/local/sbin:${EPREFIX}/usr/local/bin:${EPREFIX}/usr/sbin:${EPREFIX}/usr/bin\"\' \
		-DSTANDARD_UTILS_PATH=\'\"${EPREFIX}/usr/bin:${EPREFIX}/usr/sbin\"\' \
		-DSYS_BASHRC=\'\"${EPREFIX}/etc/bash/bashrc\"\' \
		-DSYS_BASH_LOGOUT=\'\"${EPREFIX}/etc/bash/bash_logout\"\' \
		-DNON_INTERACTIVE_LOGIN_SHELLS \
		-DSSH_SOURCE_BASHRC \
		$(use bashlogger && echo -DSYSLOG_HISTORY)

	# Don't even think about building this statically without
	# reading Bug 7714 first.  If you still build it statically,
	# don't come crying to us with bugs ;).
	#use static && export LDFLAGS="${LDFLAGS} -static"

	if use plugins; then
		append-ldflags -Wl,-rpath,/usr/lib64/bash
	else
		# Disable the plugins logic by hand since bash doesn't
		# provide a way of doing it.
		export ac_cv_func_dl{close,open,sym}=no \
			ac_cv_lib_dl_dlopen=no ac_cv_header_dlfcn_h=no
		sed -i \
			-e '/LOCAL_LDFLAGS=/s:-rdynamic::' \
			configure || die
	fi
	tc-export AR #444070
	econf "${myconf[@]}"
}

src_compile() {
	emake

	if use plugins ; then
		emake -C examples/loadables all others
	fi
}

src_install() {
	local d f

	default

	insinto /etc/bash
	doins "${FILESDIR}"/bash_logout
	doins "$(prefixify_ro "${FILESDIR}"/bashrc)"
	keepdir /etc/bash/bashrc.d
	insinto /etc/skel
	for f in bash{_logout,_profile,rc} ; do
		newins "${FILESDIR}"/dot-${f} .${f}
	done

	local sed_args=(
		-e "s:#${USERLAND}#@::"
		-e '/#@/d'
	)

	sed -i \
		"${sed_args[@]}" \
		"${ED%/}"/etc/skel/.bashrc \
		"${ED%/}"/etc/bash/bashrc || die

	if use plugins ; then
		exeinto /usr/lib64/bash
		doexe $(echo examples/loadables/*.o | sed 's:\.o::g')
		insinto /usr/include/bash-plugins
		doins *.h builtins/*.h include/*.h lib/{glob/glob.h,tilde/tilde.h}
	fi

	if use examples ; then
		for d in examples/{functions,misc,scripts,startup-files} ; do
			exeinto /usr/share/doc/${PF}/${d}
			insinto /usr/share/doc/${PF}/${d}
			for f in ${d}/* ; do
				if [[ ${f##*/} != PERMISSION ]] && [[ ${f##*/} != *README ]] ; then
					doexe ${f}
				else
					doins ${f}
				fi
			done
		done
	fi

	doman doc/*.1
	newdoc CWRU/changelog ChangeLog
	dosym bash.info /usr/share/info/bashref.info
}

pkg_preinst() {
	if [[ -e ${EROOT}/etc/bashrc ]] && [[ ! -d ${EROOT}/etc/bash ]] ; then
		mkdir -p "${EROOT}"/etc/bash
		mv -f "${EROOT}"/etc/bashrc "${EROOT}"/etc/bash/
	fi

	if [[ -L ${EROOT}/usr/bin/sh ]] ; then
		local target=$(readlink "${EROOT}"/usr/bin/sh)
		local tmp=$(emktemp "${EROOT}"/usr/bin)
		ln -sf "${target}" "${tmp}"
		mv -f "${tmp}" "${EROOT}"/usr/bin/sh
	fi
}

pkg_postinst() {
	# If /bin/sh does not exist, provide it
	if [[ ! -e ${EROOT}/usr/bin/sh ]] ; then
		ln -sf bash "${EROOT}"/usr/bin/sh
	fi
}
