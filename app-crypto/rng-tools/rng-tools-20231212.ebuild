# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="Daemon to use hardware random number generators"
HOMEPAGE="https://github.com/nhorman/rng-tools"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/nhorman/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=e7bd6c8090d81b7246b914497779382b3baf5e9f
	SRC_URI="https://github.com/nhorman/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

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
