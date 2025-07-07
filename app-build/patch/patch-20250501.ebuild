# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=d161c9a9dbd24bb7e0356e4e07983345777d85aa

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/patch"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/patch/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test xattr"

DEPEND="
	xattr? ( app-core/attr )
	test? ( app-core/ed )
"

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	use static && append-ldflags -static

	econf $(use_enable xattr)
}
