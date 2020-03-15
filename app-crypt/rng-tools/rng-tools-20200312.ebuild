# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd toolchain-funcs

DESCRIPTION="Daemon to use hardware random number generators"
HOMEPAGE="https://github.com/nhorman/rng-tools"
SRC_URI="https://github.com/nhorman/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/nhorman/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=99d6200b1cb438d25e2b1de9a8d5f82f530fc1c9
	SRC_URI="https://github.com/nhorman/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+jitterentropy nistbeacon selinux"

DEPEND="sys-fs/sysfsutils"

src_prepare() {
	echo 'bin_PROGRAMS = randstat' >> contrib/Makefile.am || die

	default

	mv README.md README || die

	eautoreconf

	sed -i '/^AR /d' Makefile.in || die
	tc-export AR
}

src_configure() {
	local myconf=(
		$(use_enable jitterentropy)
		$(use_with nistbeacon)
		--without-pkcs11
		--without-rtlsdr
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	systemd_dounit "${FILESDIR}"/rngd.service
}
