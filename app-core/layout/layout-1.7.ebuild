# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Base Configuration and File Structure"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd sysusersd tmpfilesd"

S=${WORKDIR}

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/ || die
	default
}

src_install() {
	for d in boot dev etc home mnt usr var opt srv/http run; do
		diropts -m0755
    	dodir /$d
	done

	install -d -m555 "${ED}"/proc
	install -d -m555 "${ED}"/sys
	install -d -m0750 "${ED}"/root
	install -d -m1777 "${ED}"/tmp
	install -d -m555 -g 11 "${ED}"/srv/ftp

	# setup /etc and /usr/share/factory/etc
	install -d "${ED}"/etc/{skel,profile.d} "${ED}"/usr/share/factory/etc
	for f in group passwd resolv.conf fstab ; do
			insopts -m 0644
			insinto /usr/share/factory/etc
			doins $f
	done

	for f in host.conf hosts inputrc issue securetty \
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

	insopts -m 0644
	insinto /etc/sysctl.d
	newins sysctl 10-1g4.conf

	# setup /var
	for d in local opt log/old lib/misc ; do
		install -d -m755 "${ED}"/var/$d
		keepdir /var/$d
	done

	install -d -m1777 "${ED}"/var/{tmp,spool/mail}
	keepdir /var/{tmp,spool/mail}

	install -d -m600 "${ED}"/var/empty
	keepdir /var/empty

	for d in bin sbin include lib share/{misc,pixmaps} src; do
		install -d -m755 "${ED}"/usr/$d
	done

	dosym -r /usr/lib /usr/lib64
	dosym -r /usr/lib /lib64
	dosym -r /usr/lib /lib

	keepdir /usr/local/lib
	dosym -r /usr/local/lib /usr/local/lib64

	dosym -r /tmp /usr/tmp

	dosym -r /usr/bin /bin
	dosym -r /usr/sbin /sbin

	if use systemd ; then
		if use sysusersd; then
			insopts -m 0644
			insinto /usr/lib/sysusers.d
			newins sysusers 1g4.conf
		fi

		if use tmpfilesd; then
			insopts -m 0644
			insinto /usr/lib/tmpfiles.d
			newins tmpfiles 1g4.conf
		fi

		# setup systemd.environment-generator
		insopts -m 0644
		insinto /usr/lib/systemd/system-environment-generators
		newins env-generator 10-1g4
	fi
}
