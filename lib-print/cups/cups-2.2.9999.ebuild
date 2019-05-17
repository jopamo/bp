# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic linux-info xdg-utils \
	pam user systemd toolchain-funcs git-r3

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="https://www.cups.org/"
EGIT_REPO_URI="https://github.com/apple/cups.git"
EGIT_BRANCH="branch-$(ver_cut 1).$(ver_cut 2)"

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="acl dbus debug lprng-compat pam
	+ssl static-libs systemd +threads usb X xinetd"

CDEPEND="
	app-text/libpaper
	lib-sys/zlib
	acl? (
		kernel_linux? (
			sys-app/acl
			sys-app/attr
		)
	)
	dbus? ( >=sys-app/dbus-1.6.18-r1 )
	!lprng-compat? ( !lib-print/lprng )
	pam? ( lib-sys/pam )
	ssl? (
		>=lib-net/gnutls-2.12.23-r6:0=
	)
	systemd? ( sys-app/systemd )
	usb? ( lib-dev/libusb )
	X? ( x11-misc/xdg-utils )
	xinetd? ( sys-app/xinetd )
"

DEPEND="${CDEPEND}
	>=dev-util/pkgconf-0-r1
"

RDEPEND="${CDEPEND}
"

PDEPEND=">=lib-print/cups-filters-1.0.43"

REQUIRED_USE="
	usb? ( threads )
"

RESTRICT="test"

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp
	enewgroup lpadmin 106

	if use kernel_linux; then
		linux-info_pkg_setup
		if  ! linux_config_exists; then
			ewarn "Can't check the linux kernel configuration."
			ewarn "You might have some incompatible options enabled."
		else
			# recheck that we don't have usblp to collide with libusb; this should now work in most cases (bug 501122)
			if use usb; then
				if linux_chkconfig_present USB_PRINTER; then
					elog "Your USB printers will be managed via libusb. In case you run into problems, "
					elog "please try disabling USB_PRINTER support in your kernel or blacklisting the"
					elog "usblp kernel module."
					elog "Alternatively, just disable the usb useflag for cups (your printer will still work)."
				fi
			else
				#here we should warn user that he should enable it so he can print
				if ! linux_chkconfig_present USB_PRINTER; then
					ewarn "If you plan to use USB printers you should enable the USB_PRINTER"
					ewarn "support in your kernel."
					ewarn "Please enable it:"
					ewarn "    CONFIG_USB_PRINTER=y"
					ewarn "in /usr/src/linux/.config or"
					ewarn "    Device Drivers --->"
					ewarn "        USB support  --->"
					ewarn "            [*] USB Printer support"
					ewarn "Alternatively, enable the usb useflag for cups and use the libusb code."
				fi
			fi
		fi
	fi
}

src_prepare() {
	default

	# Remove ".SILENT" rule for verbose output (bug 524338).
	sed 's#^.SILENT:##g' -i "${S}"/Makedefs.in || die "sed failed"

	# Fix install-sh, posix sh does not have 'function'.
	sed 's#function gzipcp#gzipcp()#g' -i "${S}/install-sh"

	AT_M4DIR=config-scripts eaclocal
	eautoconf
}

src_configure() {
	export DSOFLAGS="${LDFLAGS}"

	einfo LINGUAS=\"${LINGUAS}\"

	local myeconfargs=()

	myeconfargs+=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		--libdir="${EPREFIX}"/usr/lib64
		--localstatedir="${EPREFIX}"/var
		--with-exe-file-perm=755
		--with-rundir="${EPREFIX}"/run/cups
		--with-cups-user=lp
		--with-cups-group=lp
		--with-docdir="${EPREFIX}"/usr/share/cups/html
		--with-languages="${LINGUAS}"
		--with-system-groups=lpadmin
		--disable-gssapi
		--with-xinetd="${EPREFIX}"/etc/xinetd.d
		$(use_enable acl)
		$(use_enable dbus)
		$(use_enable debug)
		$(use_enable debug debug-guards)
		$(use_enable debug debug-printfs)
		$(use_enable pam)
		$(use_enable static-libs static)
		$(use_enable threads)
		$(use_enable ssl gnutls)
		$(use_enable systemd)
		$(use_enable usb libusb)
		--disable-avahi
		--disable-dnssd
		--enable-libpaper
	)

	if tc-is-static-only; then
		myeconfargs+=(
			--disable-shared
		)
	fi

	econf "${myeconfargs[@]}"

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
	rm -f "${ED}"/etc/cups/cupsd.conf.default

	# clean out cups init scripts
	rm -rf "${ED}"/etc/{init.d/cups,rc*,pam.d/cups}

	# install our pam script
	pamd_mimic_system cups auth account

	if use xinetd ; then
		# correct path
		sed -i \
			-e "s:server = .*:server = /usr/libexec/cups/daemon/cups-lpd:" \
			"${ED}"/etc/xinetd.d/cups-lpd || die
		# it is safer to disable this by default, bug #137130
		grep -w 'disable' "${ED}"/etc/xinetd.d/cups-lpd || \
			{ sed -i -e "s:}:\tdisable = yes\n}:" "${ED}"/etc/xinetd.d/cups-lpd || die ; }
		# write permission for file owner (root), bug #296221
		fperms u+w /etc/xinetd.d/cups-lpd || die "fperms failed"
	else
		# always configure with --with-xinetd= and clean up later,
		# bug #525604
		rm -rf "${ED}"/etc/xinetd.d
	fi

	keepdir /usr/libexec/cups/driver /usr/share/cups/{model,profiles} \
		/var/log/cups /var/spool/cups/tmp

	keepdir /etc/cups/{interfaces,ppd,ssl}

	use X || rm -r "${ED}"/usr/share/applications

	# create /etc/cups/client.conf, bug #196967 and #266678
	echo "ServerName ${EPREFIX}/run/cups/cups.sock" >> "${ED}"/etc/cups/client.conf

	# the following file is now provided by cups-filters:
	rm -r "${ED}"/usr/share/cups/banners || die
	rm -rf "${ED}"/var/cache

	# for the special case of running lprng and cups together, bug 467226
	if use lprng-compat ; then
		rm -fv "${ED}"/usr/bin/{lp*,cancel}
		rm -fv "${ED}"/usr/sbin/lp*
		rm -fv "${ED}"/usr/share/man/man1/{lp*,cancel*}
		rm -fv "${ED}"/usr/share/man/man8/lp*
		ewarn "Not installing lp... binaries, since the lprng-compat useflag is set."
		ewarn "Unless you plan to install an exotic server setup, you most likely"
		ewarn "do not want this. Disable the useflag then and all will be fine."
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
