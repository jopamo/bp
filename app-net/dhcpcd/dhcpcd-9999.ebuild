# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils systemd toolchain-funcs

DESCRIPTION="A fully featured, yet light weight RFC2131 compliant DHCP client"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd/"
LICENSE="BSD-2"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/rsmarples/dhcpcd.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/rsmarples/dhcpcd/archive/${P}.tar.gz"
	S=${WORKDIR}/${PN}-${P}
fi

DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

src_configure()
{
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dhcp6
		--disable-inet6
		--small
	)
	econf ${myconf[@]}
}

src_install()
{
	default
	systemd_dounit "${FILESDIR}"/${PN}.service
	rm -rf "${ED}"/var/db
}

pkg_postinst()
{
	local dbdir="${EROOT%/}"/var/lib/dhcpcd old_files=

	local old_old_duid="${EROOT%/}"/var/lib/dhcpcd/dhcpcd.duid
	local old_duid="${EROOT%/}"/etc/dhcpcd.duid
	local new_duid="${dbdir}"/duid
	if [ -e "${old_old_duid}" ]; then
		# Upgrade the duid file to the new format if needed
		if ! grep -q '..:..:..:..:..:..' "${old_old_duid}"; then
			sed -i -e 's/\(..\)/\1:/g; s/:$//g' "${old_old_duid}"
		fi

		# Move the duid to /etc, a more sensible location
		if [ ! -e "${old_duid}" ]; then
			cp -p "${old_old_duid}" "${new_duid}"
		fi
		old_files="${old_files} ${old_old_duid}"
	fi

	# dhcpcd-7 moves the files out of /etc
	if [ -e "${old_duid}" ]; then
		if [ ! -e "${new_duid}" ]; then
			cp -p "${old_duid}" "${new_duid}"
		fi
		old_files="${old_files} ${old_duid}"
	fi
	local old_secret="${EROOT%/}"/etc/dhcpcd.secret
	local new_secret="${dbdir}"/secret
	if [ -e "${old_secret}" ]; then
		if [ ! -e "${new_secret}" ]; then
			cp -p "${old_secret}" "${new_secret}"
		fi
		old_files="${old_files} ${old_secret}"
	fi

	# dhcpcd-7 renames some files in /var/lib/dhcpcd
	local old_rdm="${dbdir}"/dhcpcd-rdm.monotonic
	local new_rdm="${dbdir}"/rdm_monotonic
	if [ -e "${old_rdm}" ]; then
		if [ ! -e "${new_rdm}" ]; then
			cp -p "${old_rdm}" "${new_rdm}"
		fi
		old_files="${old_files} ${old_rdm}"
	fi
	local lease=
	for lease in "${dbdir}"/dhcpcd-*.lease*; do
		[ -f "$lease" ] || continue
		old_files="${old_files} ${lease}"
		local new_lease=$(basename "$lease" | sed -e "s/dhcpcd-//")
		[ -e "${dbdir}/${new_lease}" ] && continue
		cp "${lease}" "${dbdir}/${new_lease}"
	done

	# Warn about removing stale files
	if [ -n "${old_files}" ]; then
		elog
		elog "dhcpcd-7 has copied dhcpcd.duid and dhcpcd.secret from"
		elog "${EROOT%/}/etc to ${dbdir}"
		elog "and copied leases in ${dbdir} to new files with the dhcpcd-"
		elog "prefix dropped."
		elog
		elog "You should remove these files if you don't plan on reverting"
		elog "to an older version:"
		local old_file=
		for old_file in ${old_files}; do
			elog "	${old_file}"
		done
	fi
}
