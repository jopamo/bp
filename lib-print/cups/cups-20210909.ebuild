# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=d03753f33432c790d7ed6c2487080e09bf884254

inherit autotools flag-o-matic linux-info user toolchain-funcs

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="https://www.cups.org/"
SRC_URI="https://github.com/apple/cups/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="acl dbus debug pam +ssl static-libs systemd usb X"

DEPEND="
	app-text/libpaper
	lib-core/zlib
	acl? (
			app-core/acl
			app-core/attr
	)
	dbus? ( app-core/dbus )
	pam? ( lib-core/pam )
	ssl? ( lib-net/gnutls )
	systemd? ( app-core/systemd )
	usb? ( lib-dev/libusb )
	X? ( xgui-live-app/xdg-utils )
"

BDEPEND="app-dev/pkgconf"
PDEPEND="lib-print/cups-filters"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.6-fix-install-perms.patch"
	"${FILESDIR}/${PN}-1.4.4-nostrip.patch"
	"${FILESDIR}/${PN}-2.3.3-user-AR.patch"
)

RESTRICT="test"

append-flags -Wno-error\=stringop-overflow

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp
	enewgroup lpadmin 106

	linux-info_pkg_setup
}

src_prepare() {
	default

	# Remove ".SILENT" rule for verbose output (bug 524338).
	sed 's#^.SILENT:##g' -i "${S}"/Makedefs.in || die "sed failed"

	# Fix install-sh, posix sh does not have 'function'.
	sed 's#function gzipcp#gzipcp()#g' -i "${S}/install-sh"

	eautoreconf

	sed -i -e "s/\-Os\ \-g//g" configure || die
}

src_configure() {
	export DSOFLAGS="${LDFLAGS}"

	einfo LINGUAS=\"${LINGUAS}\"

	local myconf=()

	myconf+=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		OPTIM="${CFLAGS}"
		--libdir="${EPREFIX}"/usr/lib
		--localstatedir="${EPREFIX}"/var
		--with-exe-file-perm=755
		--with-rundir="${EPREFIX}"/run/cups
		--with-cups-user=lp
		--with-cups-group=lp
		--with-docdir="${EPREFIX}"/usr/share/cups/html
		--with-languages="${LINGUAS}"
		--with-system-groups=lpadmin
		--disable-gssapi
		--without-xinetd
		$(use_enable acl)
		$(use_enable dbus)
		$(use_enable debug)
		$(use_enable debug debug-guards)
		$(use_enable debug debug-printfs)
		$(use_enable pam)
		$(use_enable static-libs static)
		$(use_enable ssl gnutls)
		$(use_enable systemd)
		$(use_enable usb libusb)
		--disable-avahi
		--disable-dnssd
		--enable-libpaper
	)

	if tc-is-static-only; then
		myconf+=(
			--disable-shared
		)
	fi

	econf "${myconf[@]}"

	# install in /usr/libexec always, instead of using /usr/lib/cups
	sed -i -e "s:SERVERBIN.*:SERVERBIN = \"\$\(BUILDROOT\)${EPREFIX}/usr/libexec/cups\":" Makedefs || die
	sed -i -e "s:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN \"${EPREFIX}/usr/libexec/cups\":" config.h || die
	sed -i -e "s:cups_serverbin=.*:cups_serverbin=\"${EPREFIX}/usr/libexec/cups\":" cups-config || die

	# additional path corrections needed for prefix, see bug 597728
	sed -i -e "s:ICONDIR.*:ICONDIR = ${EPREFIX}/usr/share/icons:" Makedefs || die
	sed -i -e "s:INITDIR.*:INITDIR = ${EPREFIX}/etc:" Makedefs || die
	sed -i -e "s:DBUSDIR.*:DBUSDIR = ${EPREFIX}/etc/dbus-1:" Makedefs || die
	sed -i -e "s:MENUDIR.*:MENUDIR = ${EPREFIX}/usr/share/applications:" Makedefs || die
}

src_install() {
	emake BUILDROOT="${D}" install

	# move the default config file to docs
	dodoc "${ED}"/etc/cups/cupsd.conf.default
	rm -f "${ED}"/etc/cups/cupsd.conf.default || die

	# clean out cups init scripts
	rm -rf "${ED}"/etc/{init.d/cups,rc*,pam.d/cups} || die

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/${PN}.pam" ${PN}
	fi

	rm -rf "${ED}"/etc/xinetd.d || die

	keepdir /usr/libexec/cups/driver /usr/share/cups/{model,profiles} \
		/var/log/cups /var/spool/cups/tmp

	keepdir /etc/cups/{interfaces,ppd,ssl}

	use X || rm -r "${ED}"/usr/share/applications

	# create /etc/cups/client.conf, bug #196967 and #266678
	echo "ServerName ${EPREFIX}/run/cups/cups.sock" >> "${ED}"/etc/cups/client.conf

	# the following file is now provided by cups-filters:
	rm -r "${ED}"/usr/share/cups/banners || die
	rm -rf "${ED}"/var/cache || die

	cleanup_install

	rm -rf "${ED}"/usr/share/icons || die
	rm -rf "${ED}"/run || die
	find "${ED}"/ -xtype l -delete || die
}
