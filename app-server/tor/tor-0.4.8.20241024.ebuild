# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user autotools

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"

SNAPSHOT=369fa42e6858cebdb39099edf84d4b49df63cfbe
SRC_URI="https://gitlab.torproject.org/tpo/core/tor/-/archive/${SNAPSHOT}/tor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/tor-${SNAPSHOT}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="lzma scrypt seccomp systemd tor-hardening test zstd"

DEPEND="
	lib-dev/libevent[ssl]
	lib-core/zlib
	virtual/ssl
	lzma? ( app-compression/xz-utils )
	scrypt? ( app-crypto/libscrypt )
	seccomp? ( lib-core/libseccomp )
	systemd? ( app-core/systemd )
	zstd? ( app-compression/zstd )
"

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
		$(use_enable test unittests) \
		$(use_enable test coverage) \
		$(use_enable zstd)
}

src_install() {
	default

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/tor.service"
	fi

	keepdir /var/lib/tor

	fperms 750 /var/lib/tor
	fowners tor:tor /var/lib/tor
}
