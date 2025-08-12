# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely"
HOMEPAGE="https://www.passwordstore.org/"
SNAPSHOT=3ca13cd8882cae4083c1c478858adbf2e82dd037
SRC_URI="https://git.zx2c4.com/password-store/snapshot/password-store-${SNAPSHOT}.tar.xz -> ${PN}-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/password-store-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="importers"


src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		BASHCOMPDIR="/usr/etc/bash_completion.d" \
		WITH_BASHCOMP=yes \
		WITH_ZSHCOMP=yes \
		WITH_FISHCOMP=yes


	if use importers; then
		exeinto /usr/share/pass/importers
		doexe contrib/importers/*
	fi
}
