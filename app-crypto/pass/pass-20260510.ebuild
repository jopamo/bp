# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely"
HOMEPAGE="https://www.passwordstore.org/"
SNAPSHOT=3ca13cd8882cae4083c1c478858adbf2e82dd037
SRC_URI="https://git.zx2c4.com/password-store/snapshot/password-store-${SNAPSHOT}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/password-store-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+git importers"

RDEPEND="
	app-core/bash
	app-crypto/gnupg
	git? ( app-core/git )
"

src_prepare() {
	default

	cp "${FILESDIR}/password-store.sh" src/password-store.sh || die "failed installing vendored password-store.sh"
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		BASHCOMPDIR="${EPREFIX}/usr/share/bash-completion/completions" \
		ZSHCOMPDIR="${EPREFIX}/usr/share/zsh/site-functions" \
		FISHCOMPDIR="${EPREFIX}/usr/share/fish/vendor_completions.d" \
		WITH_BASHCOMP=yes \
		WITH_ZSHCOMP=yes \
		WITH_FISHCOMP=yes \
		|| die

	dodoc README INSTALL || die

	if use importers; then
		exeinto /usr/share/${PN}/importers
		doexe contrib/importers/* || die
	fi
}

pkg_postinst() {
	if use importers; then
		einfo "Importer helper scripts were installed to:"
		einfo "  ${EROOT}/usr/share/${PN}/importers/"
	fi
}
