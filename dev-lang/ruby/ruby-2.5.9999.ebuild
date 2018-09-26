# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3 multilib-minimal

SLOT=0

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="https://www.ruby-lang.org/"
EGIT_REPO_URI="https://github.com/ruby/ruby.git"
EGIT_BRANCH="ruby_2_5"

LICENSE="|| ( Ruby-BSD BSD-2 )"
KEYWORDS="amd64 arm64 x86"
IUSE="debug doc jemalloc socks5 static-libs"

src_prepare() {
	einfo "Removing bundled libraries..."
	rm -fr ext/fiddle/libffi-3.2.1 || die
	eautoreconf
	default
}

multilib_src_configure() {
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir=${EPREFIX}/usr/share/doc/${P} \
		--enable-shared
		--enable-pthread
		--disable-rpath
		--with-out-ext="dbm tk"
		$(use_with jemalloc jemalloc)
		$(use_enable socks5 socks)
		$(use_enable doc install-doc)
		--disable-ipv6
		$(use_enable static-libs static)
		$(use_enable static-libs install-static-library)
		$(use_with static-libs static-linked-ext)
		$(use_enable debug)
		--enable-option-checking=no
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
