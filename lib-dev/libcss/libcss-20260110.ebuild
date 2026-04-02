# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="CSS parser and selection library"
HOMEPAGE="https://www.netsurf-browser.org/projects/libcss/ https://github.com/netsurf-browser/libcss"
SNAPSHOT=104d87fde48b9e022cd3cdad28aeb4d8cc0a0c5a
BS_SNAPSHOT=0005ae300283ff01c2e2b05e7376b3e55dea21f7
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
