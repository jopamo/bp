# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info autotools

DESCRIPTION="Embedded Linux Library provides core, low-level functionality for system daemons"
HOMEPAGE="https://01.org/ell"
SRC_URI="https://mirrors.edge.kernel.org/pub/linux/libs/${PN}/${P}.tar.xz"

#SNAPSHOT=7bed251f8020ef896043f008276f41cd13fdd43f
#SRC_URI="https://kernel.googlesource.com/pub/scm/libs/ell/ell/+archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"

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

src_prepare() {
	filter-flags -Wl,-z,defs

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
