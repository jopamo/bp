# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517="uv-build"

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/ffmpeg-progress-yield
	dev-pypi/mutagen
	dev-pypi/rich
	dev-pypi/rich-argparse
"
# lockstep-pypi-deps: end
DESCRIPTION="Audio Normalization for Python/ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"
SNAPSHOT=29534fb6445c5d737e4d1ecfc5ffadc4699fa088
SRC_URI="https://github.com/slhck/ffmpeg-normalize/archive/${SNAPSHOT}.tar.gz -> ffmpeg-normalize-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ffmpeg-normalize-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND+="
	xmedia-app/ffmpeg
"

DEPEND="
	dev-pypi/tqdm[${PYTHON_USEDEP}]
	dev-pypi/ffmpeg-progress-yield[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/ffmpeg-normalize-test-optional-mp3.patch" )

distutils_enable_tests pytest

python_test() {
	# The ground-truth suite downloads a separate music corpus.
	epytest --ignore=tests/test_api_ground_truth.py
}
