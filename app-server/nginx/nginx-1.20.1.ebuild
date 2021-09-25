# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user

DESCRIPTION="Robust, small and high performance http and reverse proxy server"
HOMEPAGE="https://nginx.org"
SRC_URI="https://nginx.org/download/${P}.tar.gz"

LICENSE="BSD-2 BSD SSLeay MIT GPL-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

IUSE="aio debug +http +http_v2_module +http-cache libatomic luajit +pcre
	pcre-jit systemd"

pkg_setup() {
	NGINX_HOME="/var/lib/nginx"
	NGINX_HOME_TMP="${NGINX_HOME}/tmp"

	ebegin "Creating nginx user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 "${NGINX_HOME}" ${PN}
	eend $?
}

src_configure() {
	use aio       && myconf+=( --with-file-aio )
	use debug     && myconf+=( --with-debug )
	use http_v2_module     && myconf+=( --with-http_v2_module )
	use libatomic && myconf+=( --with-libatomic )
	use pcre      && myconf+=( --with-pcre )
	use pcre-jit  && myconf+=( --with-pcre-jit )

	local myconf=(
		--prefix="${EPREFIX}"/etc/nginx
    	--conf-path="${EPREFIX}"/etc/nginx/nginx.conf
    	--sbin-path="${EPREFIX}"/usr/sbin/nginx
    	--pid-path="${EPREFIX}"/run/nginx.pid
    	--lock-path="${EPREFIX}"/run/lock/nginx.lock
    	--user=nginx
    	--group=nginx
    	--with-threads
	)
	ECONF_SOURCE=${S} ${S}/configure "${myconf[@]}"
}

src_compile() {
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	default

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi

	doman man/nginx.8

	# just keepdir. do not copy the default htdocs files (bug #449136)
	keepdir /var/www/localhost
	rm -rf "${D}"/usr/html || die

	keepdir /var/log/nginx

	fperms 0710 /var/log/nginx
	fowners 0:${PN} /var/log/nginx

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/nginx.logrotate nginx
}
