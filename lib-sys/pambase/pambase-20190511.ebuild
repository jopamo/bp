# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="PAM base configuration files"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks"

src_compile() { :; }

src_test() { :; }

src_install() {
	insinto /etc/pam.d/

	for x in system-auth system-login system-local-login system-remote-login system-services other  ; do
		doins ${x}
	done
}
