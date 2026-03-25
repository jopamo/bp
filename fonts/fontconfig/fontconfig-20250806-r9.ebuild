# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SNAPSHOT=22cbfff10da57dc56a497387d16478db064eb210
SRC_URI="https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${SNAPSHOT}/fontconfig-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/fontconfig-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/freetype"

src_install() {
	meson_src_install

	if [[ -d "${ED}"/var/cache/fontconfig ]]; then
		rmdir "${ED}"/var/cache/fontconfig || die "expected empty runtime cache dir: ${ED}/var/cache/fontconfig"
	fi
	if [[ -d "${ED}"/var/cache ]]; then
		rmdir "${ED}"/var/cache || die "expected empty runtime cache dir: ${ED}/var/cache"
	fi
	if [[ -d "${ED}"/var ]]; then
		rmdir "${ED}"/var || die "expected empty runtime cache dir: ${ED}/var"
	fi
}
