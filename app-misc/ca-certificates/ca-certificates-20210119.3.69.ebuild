# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="$(ver_cut 1)"

inherit python-any-r1

DEB_VER=$(ver_cut 1)
NSS_VER=$(ver_cut 2-)
RTM_NAME="NSS_${NSS_VER//./_}_RTM"

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="https://packages.debian.org/sid/ca-certificates"
NMU_PR=""
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${DEB_VER}${NMU_PR:++nmu}${NMU_PR}.tar.xz
		https://archive.mozilla.org/pub/security/nss/releases/${RTM_NAME}/src/nss-${NSS_VER}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-misc/c_rehash
	app-core/debianutils
"

S=${WORKDIR}

pkg_setup() {
	# For the conversion to having it in CONFIG_PROTECT_MASK,
	# we need to tell users about it once manually first.
	[[ -f "${EPREFIX}"/etc/env.d/98ca-certificates ]] \
		|| ewarn "You should run update-ca-certificates manually after etc-update"
}

src_unpack() {
	default
	# Initial 20200601 deb release had bad naming inside the debian source tarball.
	DEB_S="${WORKDIR}/${PN}-${DEB_VER}"
	DEB_BAD_S="${WORKDIR}/work"
	if [[ -d "${DEB_BAD_S}" ]] && [[ ! -d "${DEB_S}" ]]; then
		mv "${DEB_BAD_S}" "${DEB_S}"
	fi

	# Do all the work in the image subdir to avoid conflicting with source
	# dirs in ${WORKDIR}.  Need to perform everything in the offset #381937
	mkdir -p "image/${EPREFIX}" || die
	cd "image/${EPREFIX}" || die
}

src_prepare() {
	cd "image/${EPREFIX}" || die

	mkdir -p usr/sbin || die
	cp -p "${S}"/${PN}-${DEB_VER}/sbin/update-ca-certificates usr/sbin/ || die

	default
	eapply -p2 "${FILESDIR}"/${PN}-20150426-root.patch
	local relp=$(echo "${EPREFIX}" | sed -e 's:[^/]\+:..:g')
	sed -i \
		-e '/="$ROOT/s:ROOT:ROOT'"${EPREFIX}"':' \
		-e '/RELPATH="\.\./s:"$:'"${relp}"'":' \
		-e 's/openssl rehash/c_rehash/' \
		usr/sbin/update-ca-certificates || die
}

src_compile() {
	cd "image/${EPREFIX}" || die

	python_setup
	local d="${S}/${PN}-${DEB_VER}/mozilla" c="usr/share/${PN}"
	# Grab the database from the nss sources.
	cp "${S}"/nss-${NSS_VER}/nss/lib/ckfw/builtins/{certdata.txt,nssckbi.h} "${d}" || die
	emake -C "${d}"

	mkdir -p etc/ssl/certs \
		etc/ca-certificates/update.d \
		"${c}"/mozilla \
		|| die

	mv "${d}"/*.crt "${c}"/mozilla/ || die

	(
		echo "# Automatically generated by ${CATEGORY}/${PF}"
		echo "# $(date -u)"
		echo "# Do not edit."
		cd "${c}" || die
		find * -name '*.crt' | LC_ALL=C sort
	) > etc/ca-certificates.conf

	sh usr/sbin/update-ca-certificates --root "${S}/image" || die
}

src_install() {
	cp -pPR image/* "${D}"/ || die

	cd ${PN}-${DEB_VER} || die
	doman sbin/*.8

	echo 'CONFIG_PROTECT_MASK="/etc/ca-certificates.conf"' > 98ca-certificates
	doenvd 98ca-certificates
}

pkg_postinst() {
	if [[ -d "${EROOT%/}/usr/local/share/ca-certificates" ]] ; then
		# if the user has local certs, we need to rebuild again
		# to include their stuff in the db.
		# However it's too overzealous when the user has custom certs in place.
		# --fresh is to clean up dangling symlinks
		"${EROOT%/}"/usr/sbin/update-ca-certificates --root "${ROOT}"
	fi

	if [[ -n "$(find -L "${EROOT%/}"/etc/ssl/certs/ -type l)" ]] ; then
		ewarn "Removing the following broken symlinks:"
		ewarn "$(find -L "${EROOT%/}"/etc/ssl/certs/ -type l -printf '%p -> %l\n' -delete)"
	fi
}
