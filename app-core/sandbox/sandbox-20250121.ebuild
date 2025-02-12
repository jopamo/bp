# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=cf038ebad92c8f3283b41daf62989665c911eaeb

inherit flag-o-matic multiprocessing autotools

DESCRIPTION="sandbox'd LD_PRELOAD hack"
HOMEPAGE="https://www.gentoo.org/proj/en/portage/sandbox/"

SRC_URI="https://github.com/gentoo/sandbox/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+nnp"

DEPEND="app-var/pax-utils"
BDEPEND="app-compression/xz-utils"

has sandbox_death_notice ${EBUILD_DEATH_HOOKS} || EBUILD_DEATH_HOOKS+=" sandbox_death_notice"

sandbox_death_notice() {
	ewarn "If configure failed with a 'cannot run C compiled programs' error, try this:"
	ewarn "FEATURES='-sandbox -usersandbox' emerge sandbox"
}

src_prepare() {
	default

	if ! use nnp ; then
		sed -i 's:PR_SET_NO_NEW_PRIVS:___disable_nnp_hack:' src/sandbox.c || die
	fi

	eautoreconf

	filter-flags -flto*
}

src_configure() {
	filter-lfs-flags

	ECONF_SOURCE="${S}" econf --disable-personalities
}

src_test() {
	# Default sandbox build will run with --jobs set to # cpus.
	emake check TESTSUITEFLAGS="--jobs=$(makeopts_jobs)"
}

src_install() {
	default
	doenvd "${FILESDIR}"/09sandbox
}

pkg_postinst() {
	mkdir -p "${EROOT}"/var/log/sandbox
	chown root:portage "${EROOT}"/var/log/sandbox
	chmod 0770 "${EROOT}"/var/log/sandbox
}
