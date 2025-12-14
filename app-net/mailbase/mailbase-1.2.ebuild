# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user

DESCRIPTION="MTA layout package"
HOMEPAGE="https://1g4.org"

LICENSE="GPL-2"
SLOT="0"
S=${WORKDIR}
KEYWORDS="amd64 arm64"

IUSE="pam"

RDEPEND="pam? ( lib-core/pam )"

pkg_setup() {
	enewgroup mail 12
	enewuser mail 8 -1 /var/spool/mail mail
	enewuser postmaster 14 -1 /var/spool/mail
}

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins "${FILESDIR}"/aliases || die
	insinto /etc
	doins "${FILESDIR}"/mailcap || die

	keepdir /var/spool/mail
	fowners root:mail /var/spool/mail
	fperms 03775 /var/spool/mail
	dosym -r /var/spool/mail /var/mail

	if use pam ; then
		local p
		for p in pop3 pop3s pops ; do
			dosym pop /etc/pam.d/${p} || die
		done
		for p in imap4 imap4s imaps ; do
			dosym imap /etc/pam.d/${p} || die
		done

		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}"/common-pamd-include pop
		newins "${FILESDIR}"/common-pamd-include imap
	fi
}

get_permissions_oct() {
	stat -c%a "${ROOT}$1"
}

pkg_postinst() {
	if [[ "$(get_permissions_oct /var/spool/mail)" != "3775" ]] ; then
		echo
		ewarn "Your ${ROOT}/var/spool/mail/ directory permissions differ from"
		ewarn "  those which mailbase wants to set it to (03775)."
		ewarn "  If you did not change them on purpose, consider running:"
		ewarn
		ewarn "    chown root:mail ${ROOT}/var/spool/mail/"
		ewarn "    chmod 03775 ${ROOT}/var/spool/mail/"
		echo
	fi
}
