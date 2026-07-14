# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=d72db1e533a1d6ee5543e02e9f8ccac97e0fcd34

inherit go-module

DESCRIPTION="Command line extension and specification for managing large files with git"
HOMEPAGE="https://git-lfs.com/"
SRC_URI="https://github.com/git-lfs/git-lfs/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"

# lockstep-go-managed: true
# lockstep-go-deps: begin
EGO_SUM=(
	"github.com/alexbrainman/sspi v0.0.0-20210105120005-909beea2cc74"
	"github.com/alexbrainman/sspi v0.0.0-20210105120005-909beea2cc74/go.mod"
	"github.com/avast/retry-go v3.0.0+incompatible"
	"github.com/avast/retry-go v3.0.0+incompatible/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.6/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dpotapov/go-spnego v0.0.0-20210315154721-298b63a54430"
	"github.com/dpotapov/go-spnego v0.0.0-20210315154721-298b63a54430/go.mod"
	"github.com/git-lfs/gitobj/v2 v2.1.1"
	"github.com/git-lfs/gitobj/v2 v2.1.1/go.mod"
	"github.com/git-lfs/go-netrc v0.0.0-20250218165306-ba0029b43d11"
	"github.com/git-lfs/go-netrc v0.0.0-20250218165306-ba0029b43d11/go.mod"
	"github.com/git-lfs/pktline v0.0.0-20210330133718-06e9096e2825"
	"github.com/git-lfs/pktline v0.0.0-20210330133718-06e9096e2825/go.mod"
	"github.com/git-lfs/wildmatch/v2 v2.0.1"
	"github.com/git-lfs/wildmatch/v2 v2.0.1/go.mod"
	"github.com/golang/groupcache v0.0.0-20241129210726-2c02b8208cf8"
	"github.com/golang/groupcache v0.0.0-20241129210726-2c02b8208cf8/go.mod"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/securecookie v1.1.1/go.mod"
	"github.com/gorilla/sessions v1.2.1"
	"github.com/gorilla/sessions v1.2.1/go.mod"
	"github.com/hashicorp/go-uuid v1.0.2"
	"github.com/hashicorp/go-uuid v1.0.2/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jcmturner/aescts/v2 v2.0.0"
	"github.com/jcmturner/aescts/v2 v2.0.0/go.mod"
	"github.com/jcmturner/dnsutils/v2 v2.0.0"
	"github.com/jcmturner/dnsutils/v2 v2.0.0/go.mod"
	"github.com/jcmturner/gofork v1.0.0"
	"github.com/jcmturner/gofork v1.0.0/go.mod"
	"github.com/jcmturner/goidentity/v6 v6.0.1"
	"github.com/jcmturner/goidentity/v6 v6.0.1/go.mod"
	"github.com/jcmturner/gokrb5/v8 v8.4.2"
	"github.com/jcmturner/gokrb5/v8 v8.4.2/go.mod"
	"github.com/jcmturner/rpc/v2 v2.0.3"
	"github.com/jcmturner/rpc/v2 v2.0.3/go.mod"
	"github.com/jmhodges/clock v1.2.0"
	"github.com/jmhodges/clock v1.2.0/go.mod"
	"github.com/klauspost/compress v1.18.7"
	"github.com/klauspost/compress v1.18.7/go.mod"
	"github.com/leonelquinteros/gotext v1.7.2"
	"github.com/leonelquinteros/gotext v1.7.2/go.mod"
	"github.com/mattn/go-isatty v0.0.22"
	"github.com/mattn/go-isatty v0.0.22/go.mod"
	"github.com/olekukonko/ts v0.0.0-20171002115256-78ecb04241c0"
	"github.com/olekukonko/ts v0.0.0-20171002115256-78ecb04241c0/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rubyist/tracerx v0.0.0-20170927163412-787959303086"
	"github.com/rubyist/tracerx v0.0.0-20170927163412-787959303086/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.10.2"
	"github.com/spf13/cobra v1.10.2/go.mod"
	"github.com/spf13/pflag v1.0.9"
	"github.com/spf13/pflag v1.0.9/go.mod"
	"github.com/ssgelm/cookiejarparser v1.0.1"
	"github.com/ssgelm/cookiejarparser v1.0.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.11.1"
	"github.com/stretchr/testify v1.11.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/xeipuuv/gojsonpointer v0.0.0-20180127040702-4e3ac2762d5f"
	"github.com/xeipuuv/gojsonpointer v0.0.0-20180127040702-4e3ac2762d5f/go.mod"
	"github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415"
	"github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415/go.mod"
	"github.com/xeipuuv/gojsonschema v1.2.0"
	"github.com/xeipuuv/gojsonschema v1.2.0/go.mod"
	"go.yaml.in/yaml/v3 v3.0.4/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20201112155050-0c6587e931a9/go.mod"
	"golang.org/x/crypto v0.53.0"
	"golang.org/x/crypto v0.53.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20191027093000-83d349e8ac1a/go.mod"
	"golang.org/x/net v0.0.0-20200114155413-6afb5195e5aa/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.56.0"
	"golang.org/x/net v0.56.0/go.mod"
	"golang.org/x/sync v0.21.0"
	"golang.org/x/sync v0.21.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.46.0"
	"golang.org/x/sys v0.46.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.38.0"
	"golang.org/x/text v0.38.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

_GOMODULE_GOPROXY_BASEURI="https://proxy.golang.org"
go-module_set_globals

SRC_URI+=" ${EGO_SUM_SRC_URI}"
# lockstep-go-deps: end
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0 BSD BSD-2 BSD-4 ISC MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

BDEPEND+=" >=app-lang/go-1.25:="

RESTRICT+=" !test? ( test )"

export GOSUMDB=off
export GOTOOLCHAIN=local

src_compile() {
	local mygobuildargs=(
		-trimpath
		-ldflags="-X github.com/git-lfs/git-lfs/v3/config.GitCommit=${SNAPSHOT} -s -w"
		-o git-lfs
		./git-lfs.go
	)

	ego build "${mygobuildargs[@]}"
}

src_install() {
	dobin git-lfs
}

src_test() {
	local mygotestargs=(
		-trimpath
		-ldflags="-X github.com/git-lfs/git-lfs/v3/config.GitCommit=${SNAPSHOT}"
		./...
	)

	ego test "${mygotestargs[@]}"
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog ""
		elog "Run 'git lfs install' once for each user account manually."
		elog "For more details see https://bugs.gentoo.org/show_bug.cgi?id=733372."
	fi
}
