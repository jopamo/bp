# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit doins

DESCRIPTION="Base Configuration and File Structure"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 router server systemd tmpfilesd user-namespaces xdp"

S=${WORKDIR}

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/ || die
	default
}

src_install() {
	for d in boot dev etc home mnt usr var opt run; do
		diropts -m0755
		dodir /$d
	done

	for d in log lib; do
		diropts -m0755
		dodir /var/$d
		keepdir /var/$d
	done

	keepdir /var/log/journal

	keepdir /var/lib/machines
	keepdir /etc/kernel/postinst.d

	install -d -m555 "${ED}"/proc
	install -d -m555 "${ED}"/sys
	install -d -m0750 "${ED}"/root
	install -d -m1777 "${ED}"/tmp

	diropts -m0755
	keepdir /srv/http

	diropts -m0555
	keepdir /srv/ftp

	# setup /etc and /usr/share/factory/etc
	install -d "${ED}"/etc/{skel,profile.d} "${ED}"/usr/share/factory/etc
	for f in group passwd resolv.conf fstab ; do
			insopts -m 0644
			insinto /usr/share/factory/etc
			doins $f
	done

	for f in host.conf hosts issue securetty \
		shells profile ; do
			insopts -m 0644
			insinto /etc
			doins $f
			insinto /usr/share/factory/etc
			doins $f
	done

	dosym -r /proc/self/mounts /etc/mtab

	for f in gshadow shadow crypttab; do
		insopts -m 0600
		insinto /usr/share/factory/etc
		doins $f
	done

	insopts -m 0644
	insinto /etc/profile.d
	doins locale.sh

	insopts -m 0644
	insinto /usr/lib
	doins os-release

	insopts -m 0644
	insinto /etc/env.d
	doins 50layout

	# setup /var
	for d in local opt log/old lib/misc ; do
		install -d -m755 "${ED}"/var/$d
		keepdir /var/$d
	done

	install -d -m1777 "${ED}"/var/spool/mail
	keepdir /var/spool/mail

	install -d -m600 "${ED}"/var/empty
	keepdir /var/empty

	for d in bin include lib share/{misc,pixmaps} src; do
		install -d -m755 "${ED}"/usr/$d
	done

	dosym -r /usr/lib /usr/lib64
	dosym -r /usr/lib /lib64
	dosym -r /usr/lib /lib

	keepdir /usr/local/lib
	dosym -r /usr/local/lib /usr/local/lib64

	dosym -r /tmp /usr/tmp

	dosym -r /usr/bin /bin
	#dosym -r /usr/bin /sbin
	#dosym -r /usr/bin /usr/sbin

	keepdir /usr/local/lib

	newsysusers sysusers 1g4.conf

	if use systemd ; then
		if use tmpfilesd; then
			insopts -m 0644
			insinto /usr/lib/tmpfiles.d
			newins tmpfiles 1g4.conf
		fi

		# setup systemd.environment-generator
		#insopts -m 0644
		#insinto /usr/lib/systemd/system-environment-generators
		#newins env-generator 10-1g4
	fi

	for f in gshadow shadow ; do
			insopts -m 0600
			insinto /usr/share/factory/1g4
			newins $f-1g4 $f
	done

	for f in group passwd ; do
			insopts -m 0644
			insinto /usr/share/factory/1g4
			newins $f-1g4 $f
	done

	if use user-namespaces; then
		echo "user.max_user_namespaces = 10000" > "${T}/99-max-user-namespaces.conf"

		insinto /etc/sysctl.d
		doins "${T}/99-max-user-namespaces.conf"
	fi

	if use router; then
		insinto /etc/sysctl.d
		doins "${FILESDIR}/sysctl-router.conf"
	fi

	if ! use ipv6; then
		insinto /etc/sysctl.d
		doins "${FILESDIR}/sysctl-disable-ipv6.conf"
	fi

	insinto /etc/sysctl.d
	doins "${FILESDIR}/sysctl-hardening.conf"

	if use server; then
		insinto /etc/sysctl.d
		doins "${FILESDIR}/sysctl-hardening-server.conf"
	fi
}

pkg_postinst() {
	sysusers_process
}
