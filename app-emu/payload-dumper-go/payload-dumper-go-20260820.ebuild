# Distributed under the terms of the GNU General Public License v2

inherit go-module

DESCRIPTION="an android OTA payload dumper"
HOMEPAGE="https://github.com/ssut/payload-dumper-go"
SNAPSHOT=05fe59e21c9f271fba38398c7c040993313ecd04
SRC_URI="https://github.com/ssut/payload-dumper-go/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
# lockstep-go-managed: true
# lockstep-go-deps: begin
EGO_SUM=(
	"github.com/VividCortex/ewma v1.1.1/go.mod"
	"github.com/VividCortex/ewma v1.2.0"
	"github.com/VividCortex/ewma v1.2.0/go.mod"
	"github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d"
	"github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d/go.mod"
	"github.com/andybalholm/brotli v1.2.2"
	"github.com/andybalholm/brotli v1.2.2/go.mod"
	"github.com/clipperhouse/uax29/v2 v2.7.0"
	"github.com/clipperhouse/uax29/v2 v2.7.0/go.mod"
	"github.com/dsnet/compress v0.0.1"
	"github.com/dsnet/compress v0.0.1/go.mod"
	"github.com/dsnet/golib v0.0.0-20171103203638-1ea166775780/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/klauspost/compress v1.4.1/go.mod"
	"github.com/klauspost/cpuid v1.2.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.27"
	"github.com/mattn/go-runewidth v0.0.27/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/spencercw/go-xz v0.0.0-20181128201811-c82a2123b492"
	"github.com/spencercw/go-xz v0.0.0-20181128201811-c82a2123b492/go.mod"
	"github.com/ulikunitz/xz v0.5.6/go.mod"
	"github.com/valyala/gozstd v1.26.0"
	"github.com/valyala/gozstd v1.26.0/go.mod"
	"github.com/vbauerster/mpb/v5 v5.4.0"
	"github.com/vbauerster/mpb/v5 v5.4.0/go.mod"
	"github.com/xyproto/randomstring v1.0.5"
	"github.com/xyproto/randomstring v1.0.5/go.mod"
	"golang.org/x/sync v0.22.0"
	"golang.org/x/sync v0.22.0/go.mod"
	"golang.org/x/sys v0.0.0-20201218084310-7d0127a74742/go.mod"
	"golang.org/x/sys v0.47.0"
	"golang.org/x/sys v0.47.0/go.mod"
	"google.golang.org/protobuf v1.36.12"
	"google.golang.org/protobuf v1.36.12/go.mod"
)

_GOMODULE_GOPROXY_BASEURI="https://proxy.golang.org"
go-module_set_globals

SRC_URI+=" ${EGO_SUM_SRC_URI}"
# lockstep-go-deps: end
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-tex/go-md2man"

RESTRICT+=" test"

src_compile() {
	go build || die
}

src_install() {
	go-md2man -in README.md -out payload-dumper-go.1 ||	die "Unable to create man page"
	dobin payload-dumper-go
	doman payload-dumper-go.1
}

src_test() {
	emake test
}
