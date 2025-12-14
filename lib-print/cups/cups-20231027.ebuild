# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=a8968fc4257322b1e4e191c4bccedea98d7b053e

inherit autotools linux-info toolchain-funcs

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="https://www.cups.org/"
SRC_URI="https://github.com/apple/cups/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/cups-${SNAPSHOT}

LICENSE="GPL-2"
KEYWORDS="amd64 arm64"

SLOT="0"
IUSE="acl dbus debug pam +ssl static-libs systemd usb"

DEPEND="
	app-tex/libpaper
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
"

BDEPEND="app-dev/pkgconf"
PDEPEND="lib-print/cups-filters"

PATCHES=(
	"${FILESDIR}/cups-2.2.6-fix-install-perms.patch"
	"${FILESDIR}/cups-1.4.4-nostrip.patch"
	"${FILESDIR}/cups-2.3.3-user-AR.patch"
)

RESTRICT="test"

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

	# additional path corrections needed for prefix
	sed -i -e "s:ICONDIR.*:ICONDIR = ${EPREFIX}/usr/share/icons:" Makedefs || die
	sed -i -e "s:INITDIR.*:INITDIR = ${EPREFIX}/etc:" Makedefs || die
	sed -i -e "s:DBUSDIR.*:DBUSDIR = ${EPREFIX}/etc/dbus-1:" Makedefs || die
	sed -i -e "s:MENUDIR.*:MENUDIR = ${EPREFIX}/usr/share/applications:" Makedefs || die
}

src_install() {
	emake BUILDROOT="${D}" install

	# move the default config file to docs
	dodoc "${ED}"/etc/cups/cupsd.conf.default
	rm "${ED}"/etc/cups/cupsd.conf.default || die

	# clean out cups init scripts
	rm -r "${ED}"/etc/{init.d/cups,rc*,pam.d/cups} || die

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/cups.pam" cups
	fi

	keepdir /usr/libexec/cups/driver /usr/share/cups/{model,profiles} \
		/var/log/cups /var/spool/cups/tmp

	keepdir /etc/cups/{interfaces,ppd,ssl}

	# create /etc/cups/client.conf
	echo "ServerName ${EPREFIX}/run/cups/cups.sock" >> "${ED}"/etc/cups/client.conf

	# the following file is now provided by cups-filters:
	rm -r "${ED}"/usr/share/cups/banners || die
	rm -r "${ED}"/var/cache || die

	cleanup_install

	rm -r "${ED}"/usr/share/{applications,icons} || die
	rm -r "${ED}"/run || die

	find "${ED}"/ -xtype l -delete || die
}
