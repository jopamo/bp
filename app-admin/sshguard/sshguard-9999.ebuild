# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd git-r3 autotools

DESCRIPTION="protects hosts from brute force attacks against ssh"
HOMEPAGE="http://sshguard.sourceforge.net/"
EGIT_REPO_URI="https://bitbucket.org/sshguard/sshguard.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

DEPEND="
	sys-devel/flex
	sys-devel/bison
	dev-python/docutils
"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default

	use systemd && systemd_dounit "${FILESDIR}"/sshguard.service
	insinto /etc
	newins "${FILESDIR}"/sshguard.conf sshguard.conf
}
