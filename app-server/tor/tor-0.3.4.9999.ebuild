# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit flag-o-matic systemd versionator user git-r3 autotools

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
EGIT_REPO_URI="https://git.torproject.org/tor.git"
EGIT_BRANCH=maint-0.3.4

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libressl lzma scrypt seccomp selinux systemd tor-hardening test web zstd"

DEPEND="
	lib-dev/libevent[ssl]
	lib-sys/zlib
	!libressl? ( lib-dev/openssl:0=[-bindist] )
	libressl? ( lib-dev/libressl:0= )
	lzma? ( app-compression/xz-utils )
	scrypt? ( app-crypt/libscrypt )
	seccomp? ( lib-sys/libseccomp )
	systemd? ( sys-app/systemd )
	zstd? ( app-compression/zstd )"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-tor )"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}/var" \
		--enable-system-torrc \
		--disable-asciidoc \
		--disable-android \
		--disable-libfuzzer \
		--disable-rust \
		--disable-restart-debugging \
		$(use_enable lzma) \
		$(use_enable scrypt libscrypt) \
		$(use_enable seccomp) \
		$(use_enable systemd) \
		--enable-gcc-hardening \
		--enable-linker-hardening \
		$(use_enable web tor2web-mode) \
		$(use_enable test unittests) \
		$(use_enable test coverage) \
		$(use_enable zstd)
}

src_install() {
	default

	systemd_dounit contrib/dist/tor.service

	keepdir /var/lib/tor

	fperms 750 /var/lib/tor
	fowners tor:tor /var/lib/tor
}
