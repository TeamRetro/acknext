TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.c

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../acknext/release/ -lacknext
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../acknext/debug/ -lacknext
else:unix: LIBS += -L$$OUT_PWD/../acknext/ -lacknext

INCLUDEPATH += $$PWD/../include
DEPENDPATH += $$PWD/../acknext


LIBS += -L$$PWD/../../tcc-0.9.26/ -ldl -ltcc
DEPENDPATH += $$PWD/../../tcc-0.9.26

DISTFILES += \
    acklevel.json \
    acknext.cfg

include(../../gl3w/gl3w.pri)
