# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2).x"
SNAPSHOT=76bac38b7dc859a6c38c195c98e146ab71df8361

inherit qa-policy toolchain-funcs user

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="https://openprinting.github.io/cups/ https://github.com/OpenPrinting/cups"
SRC_URI="https://github.com/OpenPrinting/cups/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cups-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="acl dbus debug +libpaper pam ssl static-libs systemd test usb X +zeroconf"

RESTRICT="!test? ( test )"

RDEPEND="
	lib-core/zlib
	acl? ( app-core/acl )
	dbus? ( virtual/dbus )
	libpaper? ( app-tex/libpaper )
	pam? ( lib-core/pam )
	ssl? ( virtual/gnutls )
	systemd? ( app-core/systemd )
	usb? ( lib-dev/libusb )
	X? ( xgui-lib/xdg-utils )
	zeroconf? ( lib-net/avahi )
"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"
PDEPEND="lib-print/cups-filters"

PATCHES=(
	"${FILESDIR}/cups-2.4.20-container-libs.patch"
	"${FILESDIR}/cups-2.4.20-no-dnssd.patch"
)

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp
	enewgroup lpadmin 106
}

src_prepare() {
	qa-policy-configure
	default

	# Package-managed data and manual pages must remain owner-writable.
	sed -i \
		-e 's/-m 444 @INSTALL_GZIP@/-m 644 @INSTALL_GZIP@/' \
		-e 's/-m 444$/-m 644/' \
		Makedefs.in || die

	# Keep all private executables in one non-multilib directory and leave
	# stripping to Corepkg.
	sed -i \
		-e 's:CUPS_SERVERBIN="$exec_prefix/lib/cups":CUPS_SERVERBIN="$exec_prefix/libexec/cups":g' \
		-e 's/INSTALL_STRIP="-s"/INSTALL_STRIP=""/' \
		configure || die

	if use elibc_musl; then
		# musl iconv intentionally omits the legacy encodings testi18n requires.
		sed -i '/^[[:space:]]*testi18n \\/d' cups/Makefile || die
	fi
}

src_configure() {
	export DSOFLAGS="${LDFLAGS}"

	local myeconfargs=(
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		RANLIB="$(tc-getRANLIB)"
		OPTIM="${CFLAGS}"
		--libdir="${EPREFIX}/usr/lib"
		--localstatedir="${EPREFIX}/var"
		--with-dbusdir="${EPREFIX}/etc/dbus-1"
		--with-docdir="${EPREFIX}/usr/share/cups/html"
		--with-icondir="${EPREFIX}/usr/share/icons"
		--with-menudir="${EPREFIX}/usr/share/applications"
		--with-pkgconfpath="${EPREFIX}/usr/lib/pkgconfig"
		--with-rundir="${EPREFIX}/run/cups"
		--with-container=none
		--with-rcdir=no
		--without-xinetd
		--with-cups-user=lp
		--with-cups-group=lp
		--with-system-groups="root lpadmin"
		--with-cupsd-file-perm=0755
		--with-exe-file-perm=0755
		--with-log-file-perm=0640
		--with-error-policy=retry-job
		--enable-sync-on-close
		--disable-gssapi
		$(use_enable acl)
		$(use_enable dbus)
		$(use_enable debug)
		$(use_enable debug debug-guards)
		$(use_enable debug debug-printfs)
		$(use_enable libpaper)
		$(use_enable pam)
		$(use_enable static-libs static)
		$(use_enable usb libusb)
		--with-tls="$(usex ssl gnutls no)"
		--with-dnssd="$(usex zeroconf avahi no)"
	)

	if use systemd; then
		myeconfargs+=(
			--with-ondemand=systemd
			--with-systemd="${EPREFIX}/usr/lib/systemd/system"
		)
	else
		myeconfargs+=( --with-ondemand=no )
	fi

	if [[ -n ${LINGUAS+x} ]]; then
		myeconfargs+=( --with-languages="${LINGUAS}" )
	fi

	if tc-is-static-only; then
		myeconfargs+=( --disable-shared )
	fi

	econf "${myeconfargs[@]}"
}

src_test() {
	export CUPS_TESTBASE="${T}/cups-tests"
	mkdir "${CUPS_TESTBASE}" || die

	# The test target builds test-only programs before starting cupsd.
	emake test
}

src_install() {
	emake BUILDROOT="${D}" install

	dodoc CHANGES.md CREDITS.md README.md
	dodoc "${ED}/etc/cups/cupsd.conf.default"
	rm "${ED}/etc/cups/cupsd.conf.default" || die

	if use pam; then
		rm -f "${ED}/etc/pam.d/cups" || die
		insinto /etc/pam.d
		newins "${FILESDIR}/cups.pam" cups
	else
		rm -rf "${ED}/etc/pam.d" || die
	fi

	keepdir \
		/etc/cups/{interfaces,ppd,ssl} \
		/usr/libexec/cups/driver \
		/usr/share/cups/{model,profiles} \
		/var/log/cups \
		/var/spool/cups/tmp

	printf 'ServerName %s/run/cups/cups.sock\n' "${EPREFIX}" > "${T}/client.conf" || die
	insinto /etc/cups
	doins "${T}/client.conf"

	# cups-filters owns banners; runtime state is created by cupsd.
	rm -rf \
		"${ED}/usr/share/cups/banners" \
		"${ED}/var/cache" \
		"${ED}/run" || die

	if ! use X; then
		rm -rf \
			"${ED}/usr/share/applications" \
			"${ED}/usr/share/icons" || die
	fi

	cleanup_install
	qa-policy-install
}
