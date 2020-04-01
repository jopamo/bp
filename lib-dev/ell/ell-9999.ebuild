# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info git-r3 autotools

DESCRIPTION="Embedded Linux Library provides core, low-level functionality for system daemons"
HOMEPAGE="https://01.org/ell"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/libs/ell/ell.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="glib test"

RESTRICT="!test? ( test )"

CONFIG_CHECK="
	~TIMERFD
	~EVENTFD
	~CRYPTO_USER_API
	~CRYPTO_USER_API_HASH
	~CRYPTO_MD5
	~CRYPTO_SHA1
	~KEY_DH_OPERATIONS
"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable glib)
		--enable-pie
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
