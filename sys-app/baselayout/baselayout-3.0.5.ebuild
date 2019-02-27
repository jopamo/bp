# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator prefix

DESCRIPTION="Filesystem baselayout"
SRC_URI="https://1g4.org/files/layout-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE=build

pkg_preinst() {
	# Bug #217848 - Since the remap_dns_vars() called by pkg_preinst() of
	# the baselayout-1.x ebuild copies all the real configs from the user's
	# /etc/conf.d into ${D}, it makes them all appear to be the default
	# versions. In order to protect them from being unmerged after this
	# upgrade, modify their timestamps.
	touch "${EROOT}"/etc/conf.d/* 2>/dev/null

	if use build ; then
		emake -C "${ED}/usr/share/${PN}" DESTDIR="${EROOT}" layout || die
	fi
	rm -f "${ED}"/usr/share/${PN}/Makefile
}

src_prepare() {
	default
	if use prefix; then
		hprefixify -e "/EUID/s,0,${EUID}," -q '"' etc/profile
		hprefixify etc/{env.d/50baselayout,shells} share.Linux/passwd
		echo PATH=/usr/bin:/bin >> etc/env.d/99host
		echo ROOTPATH=/usr/sbin:/sbin:/usr/bin:/bin >> etc/env.d/99host
	fi

	local libdir ldpaths
	ldpaths+=":${EPREFIX}/usr/${get_libdir}"
	echo "LDPATH='${ldpaths#:}'" >> etc/env.d/50baselayout
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		install

	# need the makefile in pkg_preinst
	insinto /usr/share/${PN}
	doins Makefile
}

pkg_postinst() {
	local x

	# We installed some files to /usr/share/baselayout instead of /etc to stop
	# (1) overwriting the user's settings
	# (2) screwing things up when attempting to merge files
	# (3) accidentally packaging up personal files with quickpkg
	# If they don't exist then we install them
	for x in master.passwd passwd shadow group fstab ; do
		[ -e "${EROOT}etc/${x}" ] && continue
		[ -e "${EROOT}usr/share/baselayout/${x}" ] || continue
		cp -p "${EROOT}usr/share/baselayout/${x}" "${EROOT}"etc
	done

	# Force shadow permissions to not be world-readable #260993
	for x in shadow ; do
		[ -e "${EROOT}etc/${x}" ] && chmod o-rwx "${EROOT}etc/${x}"
	done

	# whine about users that lack passwords #193541
	if [[ -e "${EROOT}"etc/shadow ]] ; then
		local bad_users=$(sed -n '/^[^:]*::/s|^\([^:]*\)::.*|\1|p' "${EROOT}"/etc/shadow)
		if [[ -n ${bad_users} ]] ; then
			echo
			ewarn "The following users lack passwords!"
			ewarn ${bad_users}
		fi
	fi

	# baselayout leaves behind a lot of .keep files, so let's clean them up
	find "${EROOT}"lib*/rcscripts/ -name .keep -exec rm -f {} + 2>/dev/null
	find "${EROOT}"lib*/rcscripts/ -depth -type d -exec rmdir {} + 2>/dev/null

	# whine about users with invalid shells #215698
	if [[ -e "${EROOT}"etc/passwd ]] ; then
		local bad_shells=$(awk -F: 'system("test -e " $7) { print $1 " - " $7}' "${EROOT}"etc/passwd | sort)
		if [[ -n ${bad_shells} ]] ; then
			echo
			ewarn "The following users have non-existent shells!"
			ewarn "${bad_shells}"
		fi
	fi

	# https://bugs.gentoo.org/361349
	if use kernel_linux; then
		mkdir -p "${EROOT}"run

		local found fstype mountpoint
		while read -r _ mountpoint fstype _; do
		[[ ${mountpoint} = /run ]] && [[ ${fstype} = tmpfs ]] && found=1
		done < "${ROOT}"proc/mounts
		[[ -z ${found} ]] &&
			ewarn "You should reboot now to get /run mounted with tmpfs!"
	fi

	for x in ${REPLACING_VERSIONS}; do
		if ! version_is_at_least 2.4 ${v}; then
			ewarn "After updating ${EROOT}etc/profile, please run"
			ewarn "env-update and . /etc/profile"
			break
		fi
	done

	if [[ -e "${EROOT}"etc/env.d/00basic ]]; then
		ewarn "${EROOT}etc/env.d/00basic is now ${EROOT}etc/env.d/50baselayout"
		ewarn "Please migrate your changes."
	fi
}
