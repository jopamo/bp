# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/${PN}.git"
DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"
KEYWORDS="amd64 arm64 x86"
LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"

QA_PREBUILT="lib/firmware/*"

src_prepare() {
	default
	echo "# Remove files that shall not be installed from this list." > ${PN}.conf
	find * \( \! -type d -and \! -name ${PN}.conf \) >> ${PN}.conf
}

src_install() {
	rm ${PN}.conf || die
	insinto /usr/lib/firmware/
	doins -r *
}
