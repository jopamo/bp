# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=ef694f7bcc60d2b92e5737e31790791ff4de20f3
PAXUTILS_SNAPSHOT=bb78da089e1086c9403a29d838231f50e9ff25c4

inherit qa-policy

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="https://www.gnu.org/software/cpio/cpio.html"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/cpio"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/cpio/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

SRC_URI+="
	https://github.com/1g4-mirror/paxutils/archive/${PAXUTILS_SNAPSHOT}.tar.gz -> paxutils-${PAXUTILS_SNAPSHOT}.tar.gz
"

LICENSE="GPL-3+ FDL-1.3+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"

PATCHES=(
	"${FILESDIR}/${PN}-bootstrap-fixes.patch"
)

BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/bison
	app-build/gettext
	app-build/gnulib
	app-build/m4
	app-build/texinfo
	app-core/git
	test? ( app-lang/perl )
"

RESTRICT="!test? ( test )"

src_prepare() {
	default

	rm -rf gnulib paxutils || die
	cp -a "${BROOT}/usr/share/gnulib" gnulib || die
	cp -a "${WORKDIR}/paxutils-${PAXUTILS_SNAPSHOT}" paxutils || die

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}/gnulib" || die
}

src_configure() {
	qa-policy-configure

	local myconf=(
		--with-rmt="${EPREFIX}/usr/libexec/rmt"
		--enable-mt
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	qa-policy-install
}
