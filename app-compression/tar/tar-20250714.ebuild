# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=892113187787c3d8a9fe112e1e85a3a546235bc1

inherit flag-o-matic

DESCRIPTION="An archiver that creates and handles file archives in various formats."
HOMEPAGE="https://www.gnu.org/software/tar/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/tar"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/tar/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl static xattr"

DEPEND="
	acl? ( app-core/acl )
	xattr? ( app-core/attr )
"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib paxutils
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	git clone https://github.com/1g4-mirror/paxutils.git
	#cd paxutils
	#git reset --hard 9ad2a83
	#cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_with acl posix-acls)
		$(use_with xattr xattrs)
		--disable-nls
		--enable-backup-scripts
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myconf[@]}"
}
