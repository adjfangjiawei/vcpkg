# portfile.cmake
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yitter/IdGenerator
    REF master
    SHA e06fc2db9379a68269021f3460464d06fde59eb8
    HEAD_REF master
)

file(COPY ${SOURCE_PATH}/C++/source/idgen/IdGenerator.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)