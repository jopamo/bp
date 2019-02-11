# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils python-any-r1

if [[ ${PV} == *.* ]] ; then
	# Compile from source ourselves.
	PRECOMPILED=false
	inherit versionator

	DEB_VER=$(get_version_component_range 1)
	NSS_VER=$(get_version_component_range 2-)
	RTM_NAME="NSS_${NSS_VER//./_}_RTM"
else
	# Debian precompiled version.
	PRECOMPILED=true
	inherit unpacker
fi

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="https://packages.debian.org/sid/ca-certificates"
NMU_PR=""
if ${PRECOMPILED} ; then
	SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}${NMU_PR:++nmu}${NMU_PR}_all.deb"
else
	SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${DEB_VER}${NMU_PR:++nmu}${NMU_PR}.tar.xz
		https://archive.mozilla.org/pub/security/nss/releases/${RTM_NAME}/src/nss-${NSS_VER}.tar.gz"
fi

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=""
if ${PRECOMPILED} ; then
	DEPEND+=" !<sys-apps/portage-2.1.10.41"
fi

RDEPEND="${DEPEND}
	sys-app/debianutils"

if ! ${PRECOMPILED}; then
	DEPEND+=" ${PYTHON_DEPS}"
fi

S=${WORKDIR}

pkg_setup() {
	# For the conversion to having it in CONFIG_PROTECT_MASK,
	# we need to tell users about it once manually first.
	[[ -f "${EPREFIX}"/etc/env.d/98ca-certificates ]] \
		|| ewarn "You should run update-ca-certificates manually after etc-update"
}

src_unpack() {
	${PRECOMPILED} || default

	# Do all the work in the image subdir to avoid conflicting with source
	# dirs in $WORKDIR.  Need to perform everything in the offset #381937
	mkdir -p "image/${EPREFIX}"
	cd "image/${EPREFIX}" || die

	${PRECOMPILED} && unpacker_src_unpack
}

src_prepare() {
	cd "image/${EPREFIX}" || die
	if ! ${PRECOMPILED} ; then
		mkdir -p usr/sbin
		cp -p "${S}"/${PN}/sbin/update-ca-certificates usr/sbin/ || die
	fi

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
	if ! ${PRECOMPILED} ; then
		python_setup
		local d="${S}/${PN}/mozilla" c="usr/share/${PN}"
		# Grab the database from the nss sources.
		cp "${S}"/nss-${NSS_VER}/nss/lib/ckfw/builtins/{certdata.txt,nssckbi.h} "${d}" || die
		emake -C "${d}"

		# Now move the files to the same places that the precompiled would.
		mkdir -p etc/ssl/certs etc/ca-certificates/update.d "${c}"/mozilla
		mv "${d}"/*.crt "${c}"/mozilla/ || die
	else
		mv usr/share/doc/{ca-certificates,${PF}} || die
	fi

	(
	echo "# Automatically generated by ${CATEGORY}/${PF}"
	echo "# $(date -u)"
	echo "# Do not edit."
	cd "${c}"
	find * -name '*.crt' | LC_ALL=C sort
	) > etc/ca-certificates.conf

	sh usr/sbin/update-ca-certificates --root "${S}/image" || die
}

src_install() {
	cp -pPR image/* "${D}"/ || die
	if ! ${PRECOMPILED} ; then
		cd ca-certificates
		doman sbin/*.8
		dodoc debian/README.* examples/ca-certificates-local/README
	fi

	echo 'CONFIG_PROTECT_MASK="/etc/ca-certificates.conf"' > 98ca-certificates
	doenvd 98ca-certificates
}

pkg_postinst() {
	if [ -d "${EROOT}/usr/local/share/ca-certificates" ] ; then
		# if the user has local certs, we need to rebuild again
		# to include their stuff in the db.
		# However it's too overzealous when the user has custom certs in place.
		# --fresh is to clean up dangling symlinks
		"${EROOT}"/usr/sbin/update-ca-certificates --root "${ROOT}"
	fi

	if [ -n "$(find -L "${EROOT}"etc/ssl/certs/ -type l)" ] ; then
		ewarn "Removing the following broken symlinks:"
		ewarn "$(find -L "${EROOT}"/etc/ssl/certs/ -type l -printf '%p -> %l\n' -delete)"
	fi
}
