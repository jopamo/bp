# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="PAM base configuration files"
EGIT_REPO_URI="https://github.com/1g4-linux/pambase.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks"

src_compile() { :; }

src_test() { :; }

src_install() {
	insinto /etc/pam.d/

	for x in login su system-auth system-login system-local-login system-remote-login system-services other  ; do
		doins ${x}
	done
}
