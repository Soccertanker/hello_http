cmake_minimum_required(VERSION 3.20)

project(dummyserv)

set(SOURCES dummy_serv.c)
set(SYSTEMD_UNIT_SOURCE hello-http-serv@.service)

include(GNUInstallDirs)
find_package(PkgConfig REQUIRED)

pkg_search_module(SYSTEMD systemd)
if (SYSTEMD_FOUND)
    pkg_get_variable(SYSTEMD_UNITDIR systemd systemd_user_unit_dir)
endif()

add_executable(dummyserv dummy_serv.c)

install(TARGETS dummyserv RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

if (SYSTEMD_FOUND)
    install(FILES ${SYSTEMD_UNIT_SOURCE} DESTINATION ${SYSTEMD_UNITDIR})
endif()
