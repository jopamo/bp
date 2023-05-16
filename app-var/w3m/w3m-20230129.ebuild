# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Text based WWW browser, supports tables and frames"
HOMEPAGE="https://github.com/tats/w3m"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tats/w3m.git"
	inherit git-r3
else
	SNAPSHOT=93ad5ee7da3bb3b6848434f0940321f345b7369c
	SRC_URI="https://github.com/tats/w3m/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="w3m"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gpm nntp ssl"

DEPEND="
	lib-core/bdwgc
	lib-core/zlib
	virtual/curses
	gpm? ( lib-core/gpm )
	ssl? ( virtual/ssl )
"

src_configure() {
	append-flags -fno-strict-aliasing

	local myconf=(
		$(use_enable gpm mouse)
		$(use_enable nntp)
		$(use_enable ssl digest-auth)
		$(use_with ssl)
		--disable-nls
		--disable-w3mmailer
		--enable-image=""
		--enable-keymap=w3m
		--enable-m17n
		--enable-unicode
		--with-charset=UTF-8
		--with-imagelib=""
		--with-termlib=yes
		--without-migemo
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
