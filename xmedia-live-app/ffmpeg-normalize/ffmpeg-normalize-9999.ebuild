# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 git-r3

DESCRIPTION="Audio Normalization for Python/ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/ffmpeg-progress-yield[${PYTHON_USEDEP}]
"
