# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="Daemon to use hardware random number generators"
HOMEPAGE="https://github.com/nhorman/rng-tools"

SNAPSHOT=ac43f91282e34e6ef2d349b6f1995cf53fb0b794
SRC_URI="https://github.com/nhorman/rng-tools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+jitterentropy nistbeacon systemd"

DEPEND="
	app-fs/sysfsutils
	app-net/curl
	lib-core/jansson
	jitterentropy? ( app-crypto/jitterentropy )
"

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

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/rngd.service"
	fi
}
