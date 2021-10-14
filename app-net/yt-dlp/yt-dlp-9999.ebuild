# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 git-r3

DESCRIPTION="a command-line program to download videos from YouTube.com and a few more sites"
HOMEPAGE="https://ytdl-org.github.io/youtube-dl/"
EGIT_REPO_URI="https://github.com/yt-dlp/yt-dlp.git"

LICENSE="unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

python_install_all() {
	distutils-r1_python_install_all
	dosym -r /usr/bin/yt-dlp /usr/bin/youtube-dl
}
