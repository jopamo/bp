# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="AI pair programming in your terminal"
HOMEPAGE="https://github.com/Aider-AI/aider"
SNAPSHOT=5cb6b610472b5153e5f30e4de7af978a0f63f854
SRC_URI="https://github.com/Aider-AI/aider/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

export SETUPTOOLS_SCM_PRETEND_VERSION="0.0.0"
