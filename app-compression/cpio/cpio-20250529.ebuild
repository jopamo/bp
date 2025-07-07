# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=ef694f7bcc60d2b92e5737e31790791ff4de20f3

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

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib paxutils
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	cd gnulib
	git reset --hard 0a12fa9
	cd ..

	git clone https://github.com/1g4-mirror/paxutils.git
	cd paxutils
	git reset --hard 9ad2a83
	cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default
}

src_configure() {
	local myconf=(
		--with-rmt="${EROOT}"/usr/libexec/rmt
		--enable-mt
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
