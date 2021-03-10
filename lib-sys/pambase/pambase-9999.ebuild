# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="PAM base configuration files"
EGIT_REPO_URI="https://gitlab.com/pjo/pambase.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks"

src_compile() { :; }

src_test() { :; }

src_install() {
	insinto /etc/pam.d
	insopts -m0644

	for x in login other su system-auth system-login system-local-login system-remote-login system-services  ; do
		doins ${x}
	done

	newins "${FILESDIR}/pam-common" chfn
	newins "${FILESDIR}/pam-common" chsh
	newins "${FILESDIR}/pam-runuser" runuser
	newins "${FILESDIR}/pam-runuser" runuser-l
	newins "${FILESDIR}/pam-su" su
	newins "${FILESDIR}/pam-su" su-l
}
