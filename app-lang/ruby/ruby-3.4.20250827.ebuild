# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="ruby_$(ver_cut 1)_$(ver_cut 2)"

inherit flag-o-matic autotools

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="https://www.ruby-lang.org/"
SNAPSHOT=38297e47945593daa3f395121c340260b9fae82d
SRC_URI="https://github.com/ruby/ruby/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/ruby-${SNAPSHOT}

LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug jemalloc socks5 static-libs"

RESTRICT="test network-sandbox"

src_prepare() {
	cp "${EROOT}"/usr/share/gnuconfig/config.{sub,guess} "${S}"/

	append-flags -fno-strict-aliasing
	filter-flags -fomit-frame-pointer -Wl,-z,defs
	default
	autoreconf -vi
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable socks5 socks)
		$(use_enable static-libs install-static-library)
		$(use_enable static-libs static)
		$(use_with jemalloc jemalloc)
		$(use_with static-libs static-linked-ext)
		--disable-install-doc
		--disable-ipv6
		--disable-rpath
		--enable-option-checking=no
		--enable-pthread
		--enable-shared
		--with-out-ext="dbm tk"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
