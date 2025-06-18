# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit user

DESCRIPTION="High-performance HTTP server and reverse proxy"
HOMEPAGE="https://nginx.org"
SNAPSHOT=481d28cb4e04c8096b9b6134856891dc52ecc68f
SRC_URI="https://github.com/nginx/nginx/archive/${SNAPSHOT}.tar.gz -> nginx-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nginx-${SNAPSHOT}"

LICENSE="BSD-2 BSD SSLeay MIT GPL-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

IUSE="
	# 'minimal' - aim for a lightweight reverse-proxy-only build
	minimal

	# Common flags
	aio
	debug
	ssl
	+http
	+http-cache
	http_v2
	http_v3
	realip
	sub
	gunzip
	gzip-static
	stub-status
	mail
	stream
	libatomic
	+pcre
	pcre-jit
	systemd
"

pkg_setup() {
	NGINX_HOME="/var/lib/nginx"

	ebegin "Creating nginx user and group"
	enewgroup "nginx"
	enewuser "nginx" -1 -1 "${NGINX_HOME}" "nginx"
	eend $?

	keepdir "${NGINX_HOME}/tmp"
}

src_configure() {
	local myconf=(
		# Core installation paths
		--prefix="${EPREFIX}/etc/nginx"
		--conf-path="${EPREFIX}/etc/nginx/nginx.conf"
		--sbin-path="${EPREFIX}/usr/bin/nginx"
		--pid-path="${EPREFIX}/run/nginx.pid"
		--lock-path="${EPREFIX}/run/lock/nginx.lock"

		# Logging
		--http-log-path="${EPREFIX}/var/log/nginx/access.log"
		--error-log-path=stderr

		# Worker user/group
		--user="nginx"
		--group="nginx"

		# Thread pools
		--with-threads
	)

	# ---------------------------------------------------------------
	# If 'minimal' is enabled, forcibly disable everything
	# that's not strictly needed for a basic HTTP reverse proxy.
	# ---------------------------------------------------------------
	if use minimal; then
		# We definitely want HTTP itself, but as minimal as possible.
		# So we do NOT disable HTTP entirely if minimal is set;
		# but we *do* disable many default modules we don't need:
		myconf+=(
			# Turn off advanced HTTP modules not required for basic reverse proxy:
			--without-http_charset_module
			--without-http_gzip_module
			--without-http_ssi_module
			--without-http_userid_module
			--without-http_access_module
			--without-http_auth_basic_module
			--without-http_mirror_module
			--without-http_autoindex_module
			--without-http_geo_module
			--without-http_map_module
			--without-http_split_clients_module
			--without-http_referer_module
			--without-http_rewrite_module
			--without-http_fastcgi_module
			--without-http_uwsgi_module
			--without-http_scgi_module
			--without-http_grpc_module
			--without-http_memcached_module
			--without-http_limit_conn_module
			--without-http_limit_req_module
			--without-http_empty_gif_module
			--without-http_browser_module
			--without-http_upstream_hash_module
			--without-http_upstream_ip_hash_module
			--without-http_upstream_least_conn_module
			--without-http_upstream_random_module
			--without-http_upstream_keepalive_module
			--without-http_upstream_zone_module

			# Turn off additional features if not specifically requested:
			--without-http_ssl_module       # We'll let USE=ssl override if needed
			--without-http_v2_module        # We'll let USE=http_v2 override
			--without-http_v3_module        # We'll let USE=http_v3 override
			--without-http_realip_module    # We'll let USE=realip override
			--without-http_sub_module       # We'll let USE=sub override
			--without-http_gunzip_module    # We'll let USE=gunzip override
			--without-http_gzip_static_module # We'll let USE=gzip-static override
			--without-http_stub_status_module # We'll let USE=stub-status override

			# Turn off mail and stream by default in minimal
			--without-mail_pop3_module
			--without-mail_imap_module
			--without-mail_smtp_module
			--without-stream_limit_conn_module
			--without-stream_access_module
			--without-stream_geo_module
			--without-stream_map_module
			--without-stream_split_clients_module
			--without-stream_return_module
			--without-stream_upstream_hash_module
			--without-stream_upstream_least_conn_module
			--without-stream_upstream_random_module
			--without-stream_upstream_zone_module
			--without-stream_ssl_preread_module
		)
	fi

	# ---------------------------------------------------------------
	# Common Feature Flags (overrides if not in minimal, or
	# if user specifically set these flags).
	# ---------------------------------------------------------------
	use debug     && myconf+=( --with-debug )
	use aio       && myconf+=( --with-file-aio )
	use libatomic && myconf+=( --with-libatomic )
	use pcre      && myconf+=( --with-pcre )
	use pcre-jit  && myconf+=( --with-pcre-jit )

	# HTTP engine
	if ! use http; then
		myconf+=( --without-http )
	else
		# If user wants to disable HTTP caching
		! use http-cache && myconf+=( --without-http_cache )
	fi

	# SSL
	if use ssl && ! use minimal; then
		myconf+=( --with-http_ssl_module )
	fi

	# HTTP/2 and HTTP/3
	use http_v2 && ! use minimal && myconf+=( --with-http_v2_module )
	use http_v3 && ! use minimal && myconf+=( --with-http_v3_module )

	# Real IP, Sub, Gunzip, Gzip Static, Stub Status
	use realip      && ! use minimal && myconf+=( --with-http_realip_module )
	use sub         && ! use minimal && myconf+=( --with-http_sub_module )
	use gunzip      && ! use minimal && myconf+=( --with-http_gunzip_module )
	use gzip-static && ! use minimal && myconf+=( --with-http_gzip_static_module )
	use stub-status && ! use minimal && myconf+=( --with-http_stub_status_module )

	# Mail and Stream proxy
	use mail   && ! use minimal && myconf+=( --with-mail )
	use stream && ! use minimal && myconf+=( --with-stream )

	# Finally, run configure
	ECONF_SOURCE="${S}" \
		"${S}/auto/configure" "${myconf[@]}"
}

src_compile() {
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	default

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/nginx.service"
	fi

	keepdir /var/log/nginx
	fperms 0710 /var/log/nginx
	fowners root:"nginx" /var/log/nginx

	keepdir /var/www/localhost

	insinto /etc/logrotate.d
	newins "${FILESDIR}/nginx.logrotate" nginx
}
