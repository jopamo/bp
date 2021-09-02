# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Text based WWW browser, supports tables and frames"
HOMEPAGE="https://github.com/tats/w3m"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tats/w3m.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=c87a5476de69c1b2e2170275ed11e2093fcc63f1
	SRC_URI="https://github.com/tats/w3m/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="w3m"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gpm nls nntp ssl unicode"

DEPEND="
	lib-core/bdwgc
	virtual/curses
	lib-core/zlib
	gpm? ( lib-core/gpm )
	ssl? ( virtual/ssl )
"

src_configure() {
	append-flags -fno-strict-aliasing

	local myconf=(
		--with-termlib=yes
		--without-migemo
		--enable-m17n
		--enable-keymap=w3m
		--disable-w3mmailer
		$(use_enable gpm mouse)
		$(use_enable nls)
		$(use_enable nntp)
		$(use_enable ssl digest-auth)
		$(use_with ssl)
		$(usex unicode "--with-charset=UTF-8" "--with-charset=US-ASCII")
		$(use_enable unicode)
		--enable-image=""
		--with-imagelib=""
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
