# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info toolchain-funcs

DESCRIPTION="Hardware Monitoring user-space utilities"
HOMEPAGE="https://hwmon.wiki.kernel.org/ https://github.com/lm-sensors/lm-sensors"

SNAPSHOT=42f240d2a457834bcbdf4dc8b57237f97b5f5854
SRC_URI="https://github.com/lm-sensors/lm-sensors/archive/${SNAPSHOT}.tar.gz -> lm-sensors-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lm-sensors-${SNAPSHOT}"

LICENSE="GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd"

RDEPEND="app-lang/perl"
BDEPEND="
	app-build/bison
	app-build/flex
"

CONFIG_CHECK="~HWMON ~I2C_CHARDEV ~I2C"
WARNING_HWMON="${PN} requires CONFIG_HWMON to be enabled for use."
WARNING_I2C_CHARDEV="sensors-detect requires CONFIG_I2C_CHARDEV to be enabled."
WARNING_I2C="${PN} requires CONFIG_I2C to be enabled for most sensors."

src_prepare() {
	default

	# Respect LDFLAGS
	sed -i -e 's/\$(LIBDIR)$/\$(LIBDIR) \$(LDFLAGS)/g' Makefile || \
		die "Failed to sed in LDFLAGS"

	sed -i \
		-e "s:^PIDFILE=\".*:PIDFILE=\"/run/fancontrol.pid\":" \
		prog/pwm/fancontrol || \
		die "Failed to adjust PIDFILE of prog/pwm/fancontrol"

	# Don't use EnvironmentFile in systemd unit
	sed -i \
		-e '/^EnvironmentFile=/d' \
		-e '/^Exec.*modprobe.*/d' \
		prog/init/lm_sensors.service || \
		die "Failed to remove EnvironmentFile from systemd unit file"

	if ! use static-libs; then
		sed -i -e '/^BUILD_STATIC_LIB/d' Makefile || \
			die "Failed to disable static building"
	fi
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		LD="$(tc-getLD)" \
		AR="$(tc-getAR)"
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		PREFIX="/usr" \
		MANDIR="/usr/share/man" \
		ETCDIR="/etc" \
		LIBDIR="/usr/lib" \
		install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins prog/init/lm_sensors.service
	fi

	cleanup_install
}
