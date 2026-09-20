# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Stores, retrieves, generates, and synchronizes passwords securely"
HOMEPAGE="https://www.passwordstore.org/"
# Linux-only local fork; see README.md for provenance and test coverage.
SRC_URI=""
S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+git importers qrcode test X"

RDEPEND="
	app-core/bash
	app-core/bx
	app-core/diffutils
	app-core/findutils
	app-core/procps
	app-core/sed
	app-core/util-linux[getopt]
	app-crypto/gnupg
	git? ( app-core/git )
	qrcode? ( xmedia-app/qrencode )
	X? ( xgui-app/xclip )
"
BDEPEND="test? ( ${RDEPEND} app-core/git )"
RESTRICT="!test? ( test )"

src_unpack() {
	if use test; then
		cp -R "${FILESDIR}/tests" "${S}/tests" || die
	fi
}

src_prepare() {
	default
	mkdir -p "${S}/src" || die
	sed \
		-e "s:^SYSTEM_EXTENSION_DIR=.*:SYSTEM_EXTENSION_DIR=\"${EPREFIX}/usr/lib/password-store/extensions\":" \
		"${FILESDIR}/password-store.sh" > "${S}/src/password-store.sh" || die "failed generating pass script"
	chmod +x "${S}/src/password-store.sh" || die
}

src_test() {
	local test failed=0
	for test in "${S}"/tests/t[0-9]*.sh; do
		bash "${test}" -v || failed=1
	done
	# The fixtures have their own agent and keys; never stop the user's agent.
	gpgconf --homedir "${S}/tests/gnupg" --kill gpg-agent || die
	[[ ${failed} == 0 ]] || die "pass tests failed"
}

src_install() {
	newbin "${S}/src/password-store.sh" pass || die
	dodir /usr/lib/password-store/extensions || die

	insinto /usr/share/licenses/${PN}
	doins "${FILESDIR}/COPYING"
	doman "${FILESDIR}/man/pass.1" || die

	insinto /usr/share/bash-completion/completions
	newins "${FILESDIR}/completion/pass.bash-completion" pass || die

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
