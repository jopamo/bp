# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Base Configuration"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="systemd"

S=${WORKDIR}

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/
	default

	local libdir ldpaths
	ldpaths+=":${EPREFIX}/usr/lib"
	echo "LDPATH='${ldpaths#:}'" >> etc/env.d/50baselayout
}

src_install() {
	for d in boot dev etc home mnt usr var opt srv/http run; do
		install -d -m755 "${ED}"/$d
	done

	install -d -m555 "${ED}"/proc
	install -d -m555 "${ED}"/sys
	install -d -m0750 "${ED}"/root
	install -d -m1777 "${ED}"/tmp
	install -d -m555 -g 11 "${ED}"srv/ftp

	# setup /etc and /usr/share/factory/etc
	install -d "${ED}"/etc/{ld.so.conf.d,skel,profile.d} "${ED}"/usr/share/factory/etc
	for f in fstab group host.conf hosts issue ld.so.conf \
		passwd resolv.conf shells profile; do
			insopts -m 0644
			insinto /etc
			doins $f
			insinto /usr/share/factory/etc
			doins $f
	done

	dosym -r /proc/self/mounts /etc/mtab

	for f in gshadow shadow crypttab; do
		insopts -m 0600
		insinto /etc
		doins $f
		insinto /usr/share/factory/etc
		doins $f
	done

	insopts -m 0644
	insinto /etc/profile.d
	doins locale.sh

	insopts -m 0644
	insinto /usr/lib
	doins os-release

	# setup /var
	for d in cache local opt log/old lib/misc empty; do
		install -d -m755 "${ED}"/var/$d
	done
	install -d -m1777 "${ED}"/var/{tmp,spool/mail}

	mkdir -p "${ED}"/run/lock
	dosym -r /run /var/run
	dosym -r /run/lock /var/lock

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
	dosym -r /usr/sbin /sbin

	if use systemd ; then
		# setup systemd-sysctl
		insopts -m 0644
		insinto /usr/lib/sysctl.d
		newins sysctl 10-1g4.conf

		# setup systemd-sysusers
		insopts -m 0644
		insinto /usr/lib/sysusers.d
		newins sysusers 1g4.conf

		# setup systemd-tmpfiles
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins sysusers 1g4.conf

		# setup systemd.environment-generator
		insopts -m 0644
		insinto /usr/lib/systemd/system-environment-generators
		newins env-generator 10-1g4
	fi
}
