# Distributed under the terms of the GNU General Public License v2

inherit doins toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="https://chrony.tuxfamily.org/"
SNAPSHOT=8382d3e7c7e58a5dd5d22caa3f19a502eec563b1
SRC_URI="https://github.com/mlichvar/chrony/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/chrony-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps cmdmon ipv6 logrotate nettle ntp phc pps refclock rtc adns systemd"

QA_CONFIG_IMPL_DECL_SKIP=(
	recvmmsg
)

DEPEND="
	nettle? ( lib-core/nettle )
	app-compression/zstd
	caps? ( lib-core/libcap )
	lib-core/libseccomp
"

RESTRICT=test

src_prepare() {
	default
	sed -i -e "s/DEVELOPMENT/${PV}/g" "configure" || die
}

src_configure() {
	tc-export CC

	local CHRONY_CONFIGURE=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--chronyrundir="${EPREFIX}"/var/run/chrony
		--chronyvardir="${EPREFIX}"/var/lib/chrony
		--sysconfdir="${EPREFIX}"/etc/chrony
		--prefix="${EPREFIX}/usr"
		$(usex adns '' --disable-asyncdns)
		$(usex caps '' --without-libcap)
		$(usex cmdmon '' --disable-cmdmon)
		$(usex ipv6 '' --disable-ipv6)
		$(usex nettle '' --without-nettle)
		$(usex ntp '' --disable-ntp)
		$(usex phc '' --disable-phc)
		$(usex pps '' --disable-pps)
		$(usex refclock '' --disable-refclock)
		$(usex rtc '' --disable-rtc)
		--enable-scfilter
		--without-editline
		--without-nss
		--without-readline
		--without-tomcrypt
		--with-user=chrony
	)
	ECONF_SOURCE=${S} ${S}/configure "${CHRONY_CONFIGURE[@]}"
}

src_install() {
	dobin chronyc
	dobin chronyd

	insinto /etc/chrony
	doins "${FILESDIR}/chrony.conf"

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${S}/examples/chrony.logrotate" chrony
	fi

	if use systemd; then
		systemd_dounit "${FILESDIR}/chronyd.service"
		dodir /usr/lib/systemd/system-preset
		cat > "${ED}/usr/lib/systemd/system-preset/80-chrony.preset" <<- EOF || die
			enable chronyd.service
		EOF
	fi

		cat > "${T}"/"${PN}"-sysusers <<- EOF || die
			g chrony 102 - -
			u chrony 102:102 "Chrony daemon" /var/lib/chrony /usr/bin/nologin
		EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		d /var/lib/chrony 0755 chrony chrony - -
		d /var/log/chrony 0755 chrony chrony - -
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
	if _doins_is_live_root; then
		use systemd && systemctl preset chronyd.service
	fi
}
