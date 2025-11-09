# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libtorrent-rasterbar
$(PKG)_WEBSITE  := https://www.libtorrent.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.11
$(PKG)_CHECKSUM := f0db58580f4f29ade6cc40fa4ba80e2c9a70c90265cd77332d3cdec37ecf1e6d
$(PKG)_SUBDIR   := libtorrent-rasterbar-$($(PKG)_VERSION)
$(PKG)_FILE     := libtorrent-rasterbar-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/arvidn/libtorrent/releases/download/libtorrent-$(subst .,_,$($(PKG)_VERSION))/libtorrent-rasterbar-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc boost openssl

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://github.com/arvidn/libtorrent/releases' | \
    $(SED) -n 's,.*libtorrent-rasterbar-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=Release \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
