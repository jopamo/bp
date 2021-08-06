# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Implementation of the library requirements of the OpenCL C programming language, as specified by the OpenCL 1.1 Specification."
HOMEPAGE="https://libclc.llvm.org/"
EGIT_REPO_URI="https://github.com/llvm/llvm-project"
EGIT_BRANCH="release/$(ver_cut 1).x"
S=${S}/${PN}

LICENSE="BSD/MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="sys-devel/llvm-roc"
