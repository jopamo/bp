# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=8d56d32648251f9fe724b433aa9d2d80669831c9

inherit autotools flag-o-matic systemd

DESCRIPTION="Tools to monitor storage systems to provide advanced warning of disk degradation"
HOMEPAGE="https://www.smartmontools.org"
SRC_URI="https://github.com/smartmontools/smartmontools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}/smartmontools

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps +daemon static update_drivedb"

DEPEND="
	caps? (
		static? ( lib-sys/libcap-ng[static-libs] )
		!static? ( lib-sys/libcap-ng )
	)"

RDEPEND="${DEPEND}
	update_drivedb? (
		app-crypt/gnupg
		|| (
			app-net/curl
			app-net/wget
			app-misc/lynx
			sys-app/subversion
		)
	)
"

REQUIRED_USE="( caps? ( daemon ) )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static
	# The build installs /etc/init.d/smartd, but we clobber it
	# in our src_install, so no need to manually delete it.
	myconf=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--with-drivedbdir="${EPREFIX}/var/db/${PN}" #575292
		--with-initscriptdir="${EPREFIX}/etc/init.d"
		$(use_with caps libcap-ng)
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		$(use_with update_drivedb gnupg)
		$(use_with update_drivedb update-smart-drivedb)
	)
	econf "${myconf[@]}"
}

src_install() {
	local db_path="/var/db/${PN}"

	if use daemon; then
		default
		systemd_newunit "${FILESDIR}"/smartd.systemd smartd.service
	else
		dosbin smartctl
		doman smartctl.8
	fi

	if use update_drivedb ; then
		if ! use daemon; then
			dosbin "${S}"/update-smart-drivedb
		fi

		exeinto /etc/cron.monthly
		doexe "${FILESDIR}/${PN}-update-drivedb"
	fi

	if use daemon || use update_drivedb; then
		keepdir "${db_path}"

		# Install a copy of the initial drivedb.h to /usr/share/${PN}
		# so that we can access that file later in pkg_postinst
		# even when dealing with binary packages (bug #575292)
		insinto /usr/share/${PN}
		doins "${S}"/drivedb.h
	fi

	# Make sure we never install drivedb.h into the db location
	# of the acutal image so we don't record hashes because user
	# can modify that file
	rm -f "${ED%/}${db_path}/drivedb.h" || die
}

pkg_postinst() {
	if use daemon || use update_drivedb; then
		local initial_db_file="${EPREFIX%/}/usr/share/${PN}/drivedb.h"
		local db_path="${EPREFIX%/}/var/db/${PN}"

		if [[ ! -f "${db_path}/drivedb.h" ]] ; then
			# No initial database found
			cp "${initial_db_file}" "${db_path}" || die
			einfo "Default drive database which was shipped with this release of ${PN}"
			einfo "has been installed to '${db_path}'."
		else
			ewarn "WARNING: There's already a drive database in '${db_path}'!"
			ewarn "Because we cannot determine if this database is untouched"
			ewarn "or was modified by the user you have to manually update the"
			ewarn "drive database:"
			ewarn ""
			ewarn "a) Replace '${db_path}/drivedb.h' by the database shipped with this"
			ewarn "   release which can be found in '${initial_db_file}', i.e."
			ewarn ""
			ewarn "     cp \"${initial_db_file}\" \"${db_path}\""
			ewarn ""
			ewarn "b) Run the following command as root:"
			ewarn ""
			ewarn "     /usr/sbin/update-smart-drivedb"

			if ! use update_drivedb ; then
				ewarn ""
				ewarn "However, 'update-smart-drivedb' requires that you re-emerge ${PN}"
				ewarn "with USE='update_drivedb'."
			fi
		fi
	fi
}
