# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs prefix

DESCRIPTION="The standard GNU Bourne again shell"
HOMEPAGE="http://tiswww.case.edu/php/chet/bash/bashtop.html"
SRC_URI="mirror://gnu/${PN}/bash-5.0.tar.gz
		mirror://gnu/${PN}/bash-5.0-patches/bash50-001
		mirror://gnu/${PN}/bash-5.0-patches/bash50-002
		mirror://gnu/${PN}/bash-5.0-patches/bash50-003
		mirror://gnu/${PN}/bash-5.0-patches/bash50-004
		mirror://gnu/${PN}/bash-5.0-patches/bash50-005
		mirror://gnu/${PN}/bash-5.0-patches/bash50-006
		mirror://gnu/${PN}/bash-5.0-patches/bash50-007
		"

S=${WORKDIR}/${PN}-5.0

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="afs bashlogger examples mem-scramble +net nls plugins"

DEPEND="
	>=lib-sys/ncurses-5.2-r2:0=
	lib-sys/readline
	nls? ( sys-devel/gettext )"

PATCHES=( 	${DISTDIR}/bash50-001
			${DISTDIR}/bash50-002
			${WORKDIR}/bash50-003
			${WORKDIR}/bash50-004
			${WORKDIR}/bash50-005
			${WORKDIR}/bash50-006
			${WORKDIR}/bash50-007	)


pkg_setup() {
	if use bashlogger ; then
		ewarn "The logging patch should ONLY be used in restricted (i.e. honeypot) envs."
		ewarn "This will log ALL output you enter into the shell, you have been warned."
	fi
}


src_prepare() {
	cp ${DISTDIR}/bash50* "${WORKDIR}/" || die

	for x in bash50-00{3,4,5,6,7} ; do
		sed -i.bak -e "s/bash-5.0-patched/bash-5.0/g" "${WORKDIR}/${x}" || die
	done

	(cd ../ && default)

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
	default

	if use plugins ; then
		exeinto /usr/lib64/bash
		doexe $(echo examples/loadables/*.o | sed 's:\.o::g')
		insinto /usr/include/bash-plugins
		doins *.h builtins/*.h include/*.h lib/{glob/glob.h,tilde/tilde.h}
	fi
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
