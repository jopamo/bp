# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="AI pair programming in your terminal"
HOMEPAGE="https://github.com/Aider-AI/aider"
SNAPSHOT=fb05748ace65bea780e0766b14b0904fbaac5f7f
SRC_URI="https://github.com/Aider-AI/aider/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

export SETUPTOOLS_SCM_PRETEND_VERSION="0.0.0"
