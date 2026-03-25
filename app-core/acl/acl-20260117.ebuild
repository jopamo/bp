# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=ae0448cb7d0d328440425d1ac347e9d6845e3f0e

inherit flag-o-matic qa-policy

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

COMMON_DEPEND="
	app-core/attr:=
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${RDEPEND}"
BDEPEND="
	app-build/gnulib
	app-build/gettext
	app-build/autoconf
	app-build/automake
	app-build/libtool
"

src_prepare() {
	rm -rf gnulib || die
	cp -r "${BROOT}"/usr/share/gnulib gnulib || die

	./autogen.sh || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
}

src_configure() {
	replace-flags -O3 -O2
	filter-flags -flto*
	qa-policy-configure
	local myconf=(
		--enable-shared $(use_enable static-libs static)
		--disable-nls
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
