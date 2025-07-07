# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=9053e722421454b115e699743a9b0a66808ab756

inherit flag-o-matic

DESCRIPTION="access control list utilities, libraries and headers"
HOMEPAGE="https://savannah.nongnu.org/projects/acl"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/acl"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/acl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-core/attr"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	./autogen.sh || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
}

src_configure() {
	replace-flags -O3 -O2
	filter-flags -flto*

	local myconf=(
		--enable-shared $(use_enable static-libs static)
		--disable-nls
	)
	econf "${myconf[@]}"
}
