# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=4d4a562d7b73dcea8bd4b2d40b8c030d5065111b

inherit flag-o-matic

DESCRIPTION="Extended attributes tools"
HOMEPAGE="https://savannah.nongnu.org/projects/attr"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/attrs"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/attr/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs debug"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib

	./autogen.sh || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
}

src_configure() {
	filter-flags -flto*

	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
		--disable-nls
		$(use_enable debug)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	insinto /usr/include/attr
	newins "${FILESDIR}"/xattr-shim.h xattr.h
}
