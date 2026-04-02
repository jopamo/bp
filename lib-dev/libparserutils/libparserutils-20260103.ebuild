# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="Utility library for parser development"
HOMEPAGE="https://www.netsurf-browser.org/projects/libparserutils/ https://github.com/netsurf-browser/libparserutils"
SNAPSHOT=6b0cbf086ca8eb8fe74b69f0c9ecf274eb2397ca
BS_SNAPSHOT=0005ae300283ff01c2e2b05e7376b3e55dea21f7
SRC_URI="
	https://github.com/netsurf-browser/libparserutils/archive/${SNAPSHOT}.tar.gz -> libparserutils-${SNAPSHOT}.tar.gz
	https://github.com/netsurf-browser/buildsystem/archive/${BS_SNAPSHOT}.tar.gz -> netsurf-buildsystem-${BS_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/libparserutils-${SNAPSHOT}"

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
