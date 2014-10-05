CMAKE_MINIMUM_REQUIRED (VERSION 2.6.0)

PROJECT (ShadowVPN)

OPTION (WITH_DEBUG "debugging support" OFF)

IF (WITH_DEBUG)
    # gdb DEBUG
    SET (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -ggdb")
ENDIF ()

INCLUDE_DIRECTORIES (
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        ${CMAKE_CURRENT_BINARY_DIR}
    )

CONFIGURE_FILE (
    "${CMAKE_CURRENT_SOURCE_DIR}/src/config.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/config.h"
    )

SET (HDR
        ${CMAKE_CURRENT_SOURCE_DIR}/src/shadowvpn.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/shell.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/args.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/vpn.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_secretbox_salsa208poly1305.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/daemon.h
    )

SET (SRC_ShadowVPN
        ${CMAKE_CURRENT_SOURCE_DIR}/src/main.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/args.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_secretbox_salsa208poly1305.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/daemon.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/log.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/shell.c
        ${CMAKE_CURRENT_SOURCE_DIR}/src/vpn.c
    )

SET (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
    "${CMAKE_CURRENT_SOURCE_DIR}/modules")

ADD_EXECUTABLE (ShadowVPN ${SRC_ShadowVPN} ${HDR})
FIND_PACKAGE (LIBSODIUM  REQUIRED )
INCLUDE_DIRECTORIES (${LIBSODIUM_INCLUDE_DIR} )
TARGET_LINK_LIBRARIES (ShadowVPN ${LIBSODIUM_LIBRARIES})

INSTALL(TARGETS ShadowVPN DESTINATION bin)
