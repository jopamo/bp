# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2-user-notifications"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="76cfcbf642358e8689af64cee815d139339f3ed8ad05103ed5eaf73db8d84cb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the UserNotifications framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"NSString_UserNotifications"
	"UNError"
	"UNNotification"
	"UNNotificationAction"
	"UNNotificationActionIcon"
	"UNNotificationAttachment"
	"UNNotificationCategory"
	"UNNotificationContent"
	"UNNotificationRequest"
	"UNNotificationResponse"
	"UNNotificationServiceExtension"
	"UNNotificationSettings"
	"UNNotificationSound"
	"UNNotificationTrigger"
	"UNUserNotificationCenter"
	"all"
	"alloc"
	"bitflags"
	"block2"
	"default"
	"objc2-core-location"
	"std"
)
