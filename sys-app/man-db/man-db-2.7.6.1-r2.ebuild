# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils user versionator

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+manpager nls selinux static-libs zlib"

CDEPEND=">=lib-dev/libpipeline-1.4.0
	lib-sys/gdbm
	sys-app/groff
	zlib? ( lib-sys/zlib )
	!sys-app/man"
DEPEND="${CDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig
	nls? (
		>=app-text/po4a-0.45
		sys-devel/gettext
	)"
RDEPEND="${CDEPEND}"
PDEPEND="manpager? ( sys-app/less )"

pkg_setup() {
	# Create user now as Makefile in src_install does setuid/chown
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_configure() {
	export ac_cv_lib_z_gzopen=$(usex zlib)
	local myeconfargs=(
		--docdir='$(datarootdir)'/doc/${PF}
		--with-systemdtmpfilesdir="${EPREFIX}"/usr/lib/tmpfiles.d
		--enable-setuid
		--enable-cache-owner=man
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x"
		$(use_enable nls)
		$(use_enable static-libs static)
		--with-db=gdbm
	)
	econf "${myeconfargs[@]}"

	# Disable color output from groff so that the manpager can add it. #184604
	sed -i \
		-e '/^#DEFINE.*\<[nt]roff\>/{s:^#::;s:$: -c:}' \
		src/man_db.conf || die
}

src_install() {
	default
	use static-libs || find "${ED}" -name "*.la" -delete || die
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/man-db.cron man-db #289884
}

pkg_preinst() {
	local cachedir="${EROOT}var/cache/man"
	# If the system was already exploited, and the attacker is hiding in the
	# cachedir of the old man-db, let's wipe them out.
	# see bug  #602588 comment 18
	local _replacing_version=
	local _setgid_vuln=0
	for _replacing_version in ${REPLACING_VERSIONS}; do
		if version_is_at_least '2.7.6.1-r2' "${_replacing_version}"; then
			debug-print "Skipping security bug #602588 ... existing installation (${_replacing_version}) should not be affected!"
		else
			_setgid_vuln=1
			debug-print "Applying cleanup for security bug #602588"
		fi
	done
	[[ ${_setgid_vuln} -eq 1 ]] && rm -rf "${cachedir}"

	# Fall back to recreating the cachedir
	if [[ ! -d ${cachedir} ]] ; then
		mkdir -p "${cachedir}" || die
		chown man:man "${cachedir}" || die
	fi

	# Update the whatis cache
	if [[ -f ${cachedir}/whatis ]] ; then
		einfo "Cleaning ${cachedir} from sys-app/man"
		find "${cachedir}" -type f '!' '(' -name index.bt -o -name index.db ')' -delete
	fi
}

pkg_postinst() {
	if [[ $(get_version_component_range 2 ${REPLACING_VERSIONS}) -lt 7 ]] ; then
		einfo "Rebuilding man-db from scratch with new database format!"
		mandb --quiet --create
	fi
}
