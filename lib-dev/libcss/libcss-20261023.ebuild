# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="CSS parser and selection library"
HOMEPAGE="https://www.netsurf-browser.org/projects/libcss/ https://github.com/netsurf-browser/libcss"
SNAPSHOT=bc6a32fe373954a67ea30e42f08a9f4f7d1db9af
BS_SNAPSHOT=e429a19d922b52e470fd8a2fd7e84a64b17175c9
SRC_URI="
	https://github.com/netsurf-browser/libcss/archive/${SNAPSHOT}.tar.gz -> libcss-${SNAPSHOT}.tar.gz
	https://github.com/netsurf-browser/buildsystem/archive/${BS_SNAPSHOT}.tar.gz -> netsurf-buildsystem-${BS_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/libcss-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	lib-dev/libparserutils
	lib-dev/libwapcaplet
"

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
