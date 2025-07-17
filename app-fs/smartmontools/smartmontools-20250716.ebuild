# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=a2b84338184e24c7b6eb46c17bd704aa8e486775

inherit autotools flag-o-matic

DESCRIPTION="Tools to monitor storage systems to provide advanced warning of disk degradation"
HOMEPAGE="https://www.smartmontools.org"
SRC_URI="https://github.com/smartmontools/smartmontools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/smartmontools-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps daemon static systemd update_drivedb"

DEPEND="
	caps? (
		static? ( lib-core/libcap-ng[static-libs] )
		!static? ( lib-core/libcap-ng )
	)"

RDEPEND="${DEPEND}
	update_drivedb? (
		app-crypto/gnupg
		|| (
			app-net/curl
			app-net/wget
			app-var/lynx
			app-core/subversion
		)
	)
"

REQUIRED_USE="( caps? ( daemon ) )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	export SMARTMONTOOLS_TEST_BUILD=1
	use static && append-ldflags -static

	myconf=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--with-drivedbdir="${EPREFIX}/var/db/smartmontools" #575292
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		$(use_with caps libcap-ng)
		$(use_with update_drivedb gnupg)
		$(use_with update_drivedb update-smart-drivedb)
	)
	econf "${myconf[@]}"
}

src_install() {
	local db_path="/var/db/smartmontools"

	if use daemon; then
		default
		insinto /usr/lib/systemd/system
		insopts -m 0644
		newins "${FILESDIR}"/smartd.systemd smartd.service
	else
		dobin smartctl
		doman smartctl.8
	fi

	if use update_drivedb ; then
		if ! use daemon; then
			dobin "${S}"/update-smart-drivedb
		fi

		exeinto /etc/cron.monthly
		doexe "${FILESDIR}/smartmontools-update-drivedb"
	fi

	if use daemon || use update_drivedb; then
		keepdir "${db_path}"

		# Install a copy of the initial drivedb.h to /usr/share/smartmontools
		# so that we can access that file later in pkg_postinst
		# even when dealing with binary packages (bug #575292)
		insinto /usr/share/smartmontools
		doins "${S}"/src/drivedb.h
	fi

	# Make sure we never install drivedb.h into the db location
	# of the acutal image so we don't record hashes because user
	# can modify that file
	rm -f "${ED%/}${db_path}/drivedb.h" || die
}
