# Distributed under the terms of the GNU General Public License v2

inherit edo

DESCRIPTION="Shell script analysis tool"
HOMEPAGE="https://www.shellcheck.net https://github.com/koalaman/shellcheck"
SNAPSHOT=cd41f794383b6159757575c9debbf198426b21aa
SRC_URI="https://github.com/koalaman/shellcheck/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

RDEPEND="lib-core/gmp"
DEPEND="${RDEPEND}"

DOCS=( CHANGELOG.md README.md shellcheck.1.md )

pkg_pretend() {
	command -v ghc >/dev/null || die "Install ghc in /usr/bin or /usr/local/bin before building ${CATEGORY}/${PF}"
	command -v cabal >/dev/null || die "Install cabal in /usr/bin or /usr/local/bin before building ${CATEGORY}/${PF}"
	command -v curl >/dev/null || die "Install curl in /usr/bin or /usr/local/bin before building ${CATEGORY}/${PF}"
}

src_compile() {
	export HOME="${T}/home"
	mkdir -p "${HOME}" || die

	edo cabal user-config init --force
	sed -i \
		-e 's|url: http://hackage.haskell.org/|url: https://hackage.haskell.org/|' \
		-e 's|-- secure: True|secure: True|' \
		"${HOME}/.config/cabal/config" || die
	edo cabal update
	edo cabal v1-install --only-dependencies --disable-tests --disable-benchmarks
	edo cabal v1-configure \
		--prefix="${EPREFIX}/usr" \
		--bindir="${EPREFIX}/usr/bin"
	edo cabal v1-build
}

src_install() {
	dobin dist/build/shellcheck/shellcheck
	einstalldocs
}
