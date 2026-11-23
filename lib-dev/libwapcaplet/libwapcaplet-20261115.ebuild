# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="String interning dictionary library"
HOMEPAGE="https://www.netsurf-browser.org/projects/libwapcaplet/ https://github.com/netsurf-browser/libwapcaplet"
SNAPSHOT=74e49210e9c56381c1e60aea309dc80074a54ede
BS_SNAPSHOT=b38fe7146aa3af08881ba9d6817f19ee7abe4a86
SRC_URI="
	https://github.com/netsurf-browser/libwapcaplet/archive/${SNAPSHOT}.tar.gz -> libwapcaplet-${SNAPSHOT}.tar.gz
	https://github.com/netsurf-browser/buildsystem/archive/${BS_SNAPSHOT}.tar.gz -> netsurf-buildsystem-${BS_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/libwapcaplet-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

PATCHES=(
	"${FILESDIR}/${PN}-no-werror.patch"
)

src_compile() {
	qa-policy-configure
	tc-export AR CC

	emake \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="lib" \
		NSSHARED="${WORKDIR}/buildsystem-${BS_SNAPSHOT}" \
		COMPONENT_TYPE="lib-shared" \
		all

	if use static-libs; then
		emake \
			PREFIX="${EPREFIX}/usr" \
			LIBDIR="lib" \
			NSSHARED="${WORKDIR}/buildsystem-${BS_SNAPSHOT}" \
			COMPONENT_TYPE="lib-static" \
			all
	fi
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="lib" \
		NSSHARED="${WORKDIR}/buildsystem-${BS_SNAPSHOT}" \
		COMPONENT_TYPE="lib-shared" \
		install

	if use static-libs; then
		emake \
			DESTDIR="${D}" \
			PREFIX="${EPREFIX}/usr" \
			LIBDIR="lib" \
			NSSHARED="${WORKDIR}/buildsystem-${BS_SNAPSHOT}" \
			COMPONENT_TYPE="lib-static" \
			install
	fi

	qa-policy-install
}
