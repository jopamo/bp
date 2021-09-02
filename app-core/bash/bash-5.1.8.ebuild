# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=ce23728687ce9e584333367075c9deef413553fa

inherit flag-o-matic toolchain-funcs

DESCRIPTION="The standard GNU Bourne again shell"
HOMEPAGE="http://tiswww.case.edu/php/chet/bash/bashtop.html"
SRC_URI="https://git.savannah.gnu.org/cgit/${PN}.git/snapshot/${PN}-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/libc
	virtual/curses
	lib-core/readline
"

src_prepare() {
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
		--enable-readline
		--enable-history
		--without-bash-malloc
		--disable-nls
	)

	append-cppflags \
		-DDEFAULT_PATH_VALUE=\'\"${EPREFIX}/usr/local/sbin:${EPREFIX}/usr/local/bin:${EPREFIX}/opt/sbin:${EPREFIX}/opt/bin:${EPREFIX}/usr/sbin:${EPREFIX}/usr/bin\"\' \
		-DSTANDARD_UTILS_PATH=\'\"${EPREFIX}/usr/bin:${EPREFIX}/usr/sbin\"\' \
		-DSYS_BASHRC=\'\"${EPREFIX}/etc/bash/bashrc\"\' \
		-DSYS_BASH_LOGOUT=\'\"${EPREFIX}/etc/bash/bash_logout\"\' \
		-DNON_INTERACTIVE_LOGIN_SHELLS \
		-DSSH_SOURCE_BASHRC

	export ac_cv_func_dl{close,open,sym}=no \
		ac_cv_lib_dl_dlopen=no ac_cv_header_dlfcn_h=no
	sed -i \
		-e '/LOCAL_LDFLAGS=/s:-rdynamic::' \
		configure || die

	econf "${myconf[@]}"
}

src_install() {
	default

	#compat symlink
	dosym -r /usr/bin/bash /usr/bin/sh

	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}"/alias.sh

	insinto /etc/bash
	doins "${FILESDIR}"/{bash_logout,bashrc}
}

pkg_preinst() {
	if [[ -e ${EROOT}/etc/bashrc ]] && [[ ! -d ${EROOT}/etc/bash ]] ; then
		mkdir -p "${EROOT}"/etc/bash
		mv -f "${EROOT}"/etc/bashrc "${EROOT}"/etc/bash/
	fi
}
