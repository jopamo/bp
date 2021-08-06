# layout Makefile

PV = 9999
PKG = layout-$(PV)

DESTDIR = ""

CHANGELOG_LIMIT = --after="1 year ago"
INSTALL_DIR    = install -m 0755 -d
INSTALL_EXE    = install -m 0755
INSTALL_FILE   = install -m 0644
INSTALL_SECURE = install -m 0600

OS=$(shell uname -s)

KEEP_DIRS = /dev \
	/run \
	/sys \
	/usr/src \
	/boot \
	/etc/profile.d \
	/home \
	/media \
	/mnt \
	/proc \
	/opt \
	/root \
	/var/cache \
	/var/empty \
	/var/lib \
	/var/log \
	/var/spool

all:

changelog:
	git log ${CHANGELOG_LIMIT} --format=full > ChangeLog

clean:

install:
	$(INSTALL_DIR) $(DESTDIR)/etc
	cp -pPR etc/* $(DESTDIR)/etc/
	$(INSTALL_DIR) $(DESTDIR)/usr/share/layout
	cp -pPR share/* $(DESTDIR)/usr/share/layout/

layout-dirs:
	# Create base filesytem layout
	for x in $(KEEP_DIRS) ; do \
		test -e $(DESTDIR)$$x/.keep && continue ; \
		$(INSTALL_DIR) $(DESTDIR)$$x || exit $$? ; \
		touch $(DESTDIR)$$x/.keep || echo "ignoring touch failure; mounted fs?" ; \
	done

layout: layout-dirs
	ln -snf /proc/self/mounts $(DESTDIR)/etc/mtab
	ln -snf /run $(DESTDIR)/var/run
	ln -snf /run/lock $(DESTDIR)/var/lock
	install -m 0700 -d $(DESTDIR)/root
	touch $(DESTDIR)/root/.keep
	install -m 1777 -d $(DESTDIR)/var/tmp
	touch $(DESTDIR)/var/tmp/.keep
	install -m 1777 -d $(DESTDIR)/tmp
	touch $(DESTDIR)/tmp/.keep
	ln -snf /var/tmp $(DESTDIR)/usr/tmp

.PHONY: all changelog clean install layout  live release snapshot

# vim: set ts=4 :
