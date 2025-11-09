# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qbittorrent
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.1.2
$(PKG)_CHECKSUM := d5806092c71959a5dbdf55c645ea45ed48a70369ab6c226039b83f1ade6979f2
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/$(PKG)-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_WEBSITE  := https://qbittorrent.org/
$(PKG)_OWNER    := https://github.com/starius
$(PKG)_DEPS     := cc boost libtorrent-rasterbar qt6-qtbase qt6-qtsvg qt6-qttools openssl $(BUILD)~geoip-database

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.qbittorrent.org/download.php' | \
    $(SED) -n 's,.*qbittorrent-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

#        --with-boost='$(PREFIX)/$(TARGET)'
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DQT_SKIP_AUTO_PLUGIN_INCLUSION=ON \
        '$(SOURCE_DIR)'
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    '$(TARGET)-cmake' --install '$(BUILD_DIR)'
endef

$(PKG)_BUILD_SHARED =
