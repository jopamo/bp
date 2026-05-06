# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Official bp font policy and curated font stack"
HOMEPAGE="https://github.com/rsms/inter"
SRC_URI=""
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	fonts/fontconfig
	fonts/inter
	fonts/atkinson-hyperlegible-next
	fonts/liberation-fonts
	fonts/libertinus
	fonts/iosevka-term
	fonts/jetbrains-mono
	fonts/cascadia-code
	fonts/fira-code
	fonts/noto-emoji
	fonts/symbols-nerd-font
"

_font_policy_is_live_root() {
	[[ ${ROOT:-/} == / ]]
}

_font_policy_update_cache() {
	_font_policy_is_live_root || return 0
	if has_version fonts/fontconfig; then
		ebegin "Updating global fontcache"
		fc-cache -fs || die "fc-cache failed"
		eend 0
	fi
}

src_install() {
	insinto /etc/fonts/conf.avail
	doins "${FILESDIR}"/60-bp-font-stack.conf

	dodir /etc/fonts/conf.d
	dosym ../conf.avail/60-bp-font-stack.conf /etc/fonts/conf.d/60-bp-font-stack.conf
}

pkg_postinst() {
	elog "bp font policy roles:"
	elog "  UI sans: Inter"
	elog "  Accessible sans: Atkinson Hyperlegible Next"
	elog "  Serif: Libertinus Serif"
	elog "  Terminal/code: Iosevka Term"
	elog "  Editor mono: JetBrains Mono"
	elog "  Windows dev mono: Cascadia Code"
	elog "  Ligature mono: Fira Code"
	elog "  Emoji: Noto Color Emoji"
	elog "  Icons: Symbols Nerd Font"
	_font_policy_update_cache
}

pkg_postrm() {
	_font_policy_update_cache
}
