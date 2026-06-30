# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely"
HOMEPAGE="https://www.passwordstore.org/"
# Vendored support files come from password-store commit 3ca13cd8882cae4083c1c478858adbf2e82dd037.
SRC_URI=""
S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+git importers"

RDEPEND="
	app-core/bash
	app-crypto/gnupg
	git? ( app-core/git )
"

src_install() {
	local pass_bin="${T}/pass"

	sed \
		-e '/PLATFORM_FUNCTION_FILE/d' \
		-e "s:^SYSTEM_EXTENSION_DIR=.*:SYSTEM_EXTENSION_DIR=\"${EPREFIX}/usr/lib/password-store/extensions\":" \
		"${FILESDIR}/password-store.sh" > "${pass_bin}" || die "failed generating pass script"

	newbin "${pass_bin}" pass || die
	dodir /usr/lib/password-store/extensions || die

	dodoc "${FILESDIR}/README" "${FILESDIR}/INSTALL" || die
	doman "${FILESDIR}/man/pass.1" || die

	insinto /usr/share/bash-completion/completions
	newins "${FILESDIR}/completion/pass.bash-completion" pass || die

	insinto /usr/share/zsh/site-functions
	newins "${FILESDIR}/completion/pass.zsh-completion" _pass || die

	insinto /usr/share/fish/vendor_completions.d
	newins "${FILESDIR}/completion/pass.fish-completion" pass.fish || die

	if use importers; then
		exeinto /usr/share/${PN}/importers
		doexe "${FILESDIR}"/importers/* || die
	fi
}

pkg_postinst() {
	if use importers; then
		einfo "Importer helper scripts were installed to:"
		einfo "  ${EROOT}/usr/share/${PN}/importers/"
	fi
}
