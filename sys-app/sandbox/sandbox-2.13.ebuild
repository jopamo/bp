# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic multilib-minimal multiprocessing

DESCRIPTION="sandbox'd LD_PRELOAD hack"
HOMEPAGE="https://www.gentoo.org/proj/en/portage/sandbox/"
SRC_URI="https://dev.gentoo.org/~mgorny/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="app-compression/xz-utils"

has sandbox_death_notice ${EBUILD_DEATH_HOOKS} || EBUILD_DEATH_HOOKS="${EBUILD_DEATH_HOOKS} sandbox_death_notice"

sandbox_death_notice() {
	ewarn "If configure failed with a 'cannot run C compiled programs' error, try this:"
	ewarn "FEATURES='-sandbox -usersandbox' emerge sandbox"
}

multilib_src_configure() {
	filter-lfs-flags #90228

	local myconf=()

	ECONF_SOURCE="${S}" \
	econf "${myconf[@]}"
}

multilib_src_test() {
	# Default sandbox build will run with --jobs set to # cpus.
	emake check TESTSUITEFLAGS="--jobs=$(makeopts_jobs)"
}

multilib_src_install_all() {
	doenvd "${FILESDIR}"/09sandbox

	keepdir /var/log/sandbox
	fowners root:portage /var/log/sandbox
	fperms 0770 /var/log/sandbox

	dodoc AUTHORS ChangeLog* NEWS README
}

pkg_preinst() {
	chown root:portage "${ED}"/var/log/sandbox
	chmod 0770 "${ED}"/var/log/sandbox

	local v
	for v in ${REPLACING_VERSIONS}; do
		if [[ ${v} == 1.* ]] ; then
			local old=$(find "${EROOT}"/lib* -maxdepth 1 -name 'libsandbox*')
			if [[ -n ${old} ]] ; then
				elog "Removing old sandbox libraries for you:"
				find "${EROOT}"/lib* -maxdepth 1 -name 'libsandbox*' -print -delete
			fi
		fi
	done
}

pkg_postinst() {
	local v
	for v in ${REPLACING_VERSIONS}; do
		if [[ ${v} == 1.* ]] ; then
			chmod 0755 "${EROOT}"/etc/sandbox.d #265376
		fi
	done
}
