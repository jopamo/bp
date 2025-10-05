# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2).x"
SNAPSHOT=8c86c9d50bbd3482de9a315f22884c26d1758023

inherit linux-info user toolchain-funcs autotools flag-o-matic

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="https://www.cups.org/"
SRC_URI="https://github.com/OpenPrinting/cups/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/cups-${SNAPSHOT}

#KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="acl dbus debug pam ssl static-libs systemd usb"

DEPEND="
	app-tex/libpaper
	lib-core/zlib
	lib-net/avahi
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
)

RESTRICT="test"

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp
	enewgroup lpadmin 106

	linux-info_pkg_setup
}

src_prepare() {
	filter-flags -flto*
	default

	# Remove ".SILENT" rule for verbose output (bug 524338).
	sed 's#^.SILENT:##g' -i "${S}"/Makedefs.in || die "sed failed"

	# Fix install-sh, posix sh does not have 'function'.
	sed 's#function gzipcp#gzipcp()#g' -i "${S}/install-sh"

	eautoreconf

	# from the top of the CUPS source tree
	sed -i -E '
		s/^[[:space:]]*INSTALL_STRIP[[:space:]]*=[[:space:]]*"[^"]*"/INSTALL_STRIP=""/;   # INSTALL_STRIP="-s"
		s/^[[:space:]]*INSTALL_STRIP[[:space:]]*=.*/INSTALL_STRIP=/                       # INSTALL_STRIP=-s  or empty
		' config-scripts/cups-compiler.m4 configure
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
		$(use_with systemd)
		$(use_enable usb libusb)
		--with-dnssd=avahi
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
