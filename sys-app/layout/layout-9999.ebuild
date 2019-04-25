# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="Base Configuration"
EGIT_REPO_URI="https://github.com/1g4-linux/layout.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE=build

pkg_preinst() {
	if use build ; then
		emake -C "${ED}/usr/share/${PN}" DESTDIR="${EROOT}" layout || die
	fi
	rm -f "${ED}"/usr/share/${PN}/Makefile
}

src_prepare() {
	default

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
}
