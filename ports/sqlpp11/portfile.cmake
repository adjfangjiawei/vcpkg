vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rbock/sqlpp11
    REF 7f04435576036fc3f06d929760b5c7623485f069 # 2022-09-14
    SHA512 1db3e0164429d26623b2498b617c2a5e65d3d071ad0aeedb0ed3548160505d5ecfd68d3e12479150de2d318aeeb73e05e5a35bdd2b60bf5456ee5da7fdbd7cfe
    HEAD_REF master
    PATCHES
        ddl2cpp_path.patch
        fix_link_sqlite3.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        sqlite3    BUILD_SQLITE3_CONNECTOR
        mariadb    BUILD_MARIADB_CONNECTOR
        mysql      BUILD_MYSQL_CONNECTOR
        postgresql BUILD_POSTGRESQL_CONNECTOR
)

# Use sqlpp11's own build process
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING:BOOL=OFF
        # Use vcpkg as source for the date library
        -DUSE_SYSTEM_DATE:BOOL=ON
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# Move CMake config files to the right place
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/Sqlpp11)

# Delete redundant and unnecessary directories
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib" "${CURRENT_PACKAGES_DIR}/cmake" "${CURRENT_PACKAGES_DIR}/include/date")

# Move python script from bin directory
file(COPY "${CURRENT_PACKAGES_DIR}/bin/sqlpp11-ddl2cpp" DESTINATION "${CURRENT_PACKAGES_DIR}/scripts")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
