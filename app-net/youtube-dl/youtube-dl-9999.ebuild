# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 git-r3

DESCRIPTION="a command-line program to download videos from YouTube.com and a few more sites"
HOMEPAGE="https://ytdl-org.github.io/youtube-dl/"
EGIT_REPO_URI="https://github.com/rg3/youtube-dl.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

src_compile() {
	distutils-r1_src_compile
}

python_install_all() {
	distutils-r1_python_install_all
	rm -r "${ED}"/usr/etc || die
}
