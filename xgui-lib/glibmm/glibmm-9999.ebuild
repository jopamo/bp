# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="the C++ API for GTK"
HOMEPAGE="https://github.com/GNOME/glibmm"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/GNOME/${PN}"
	inherit git-r3
else
	SNAPSHOT=8c8816dec34932751f3f9dd1b44b56eebf2b3ed3
	SRC_URI="https://github.com/GNOME/glibmm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="lib-dev/libsigc++"

src_prepare() {
	default

	# giomm_tls_client requires FEATURES=-network-sandbox and glib-networking rdep
	sed -i -e '/giomm_tls_client/d' tests/meson.build || die

	if ! use test; then
		sed -i -e "/^subdir('tests')/d" meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		-Db_pch=true
		-Dmaintainer-mode=true
		-Dbuild-deprecated-api=true
		-Dbuild-documentation=false
		-Dbuild-examples=false
		-Dmsvc14x-parallel-installable=false
	)

	meson_src_configure "${emesonargs[@]}"
}
