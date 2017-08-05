TEMPLATE = lib
CONFIG += c++11
CONFIG -= app_bundle
CONFIG -= qt
unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += ode dotconf sdl2 SDL2_image SDL2_mixer

CONFIG += ackGraphics ackScheduler

INCLUDEPATH += $$PWD/include
INCLUDEPATH += $$PWD/src

DEPENDPATH += $$PWD/include
DEPENDPATH += $$PWD/src

LIBS += -lphysfs

DEFINES += _ACKNEXT_INTERNAL_

ackGraphics {
	include(../../gl3w/gl3w.pri)
	unix: PKGCONFIG += assimp gl
}

ackScript {
	INCLUDEPATH += $$PWD/../../tcc-0.9.26
	DEPENDPATH += $$PWD/../../tcc-0.9.26
	LIBS += -L$$PWD/../../tcc-0.9.26/ -ldl -ltcc
}

ackJSON {
	# Used for levels
	INCLUDEPATH += $$PWD/../../json/src
}

ackScheduler {
	DISTFILES += \
		linker.ld
	QMAKE_LFLAGS += -T$$quote($$PWD/linker.ld)

	HEADERS += \
		$$PWD/../coroutine/coroutine.h

	SOURCES += \
		$$PWD/../coroutine/coroutine.c

	DEFINES += ACKNEXT_HAS_SCHEDULER
}

HEADERS += \
    src/graphics/opengl/buffer.hpp \
    src/graphics/opengl/shader.hpp \
    src/graphics/scene/material.hpp \
    src/graphics/scene/mesh.hpp \
    src/graphics/scene/stage.hpp \
    src/graphics/scene/pipeline.hpp \
    src/graphics/scene/model.hpp \
    src/graphics/scene/light.hpp \
    src/graphics/scene/camera.hpp \
    src/graphics/opengl/bitmap.hpp \
    src/scene/entity.hpp \
    src/collision/collision.hpp \
    src/collision/hull.hpp \
    src/graphics/core/view.hpp \
    src/scheduler/task.hpp \
    src/events/event.hpp \
    src/input/gamepad.hpp \
    src/input/joystick.hpp \
    src/core/engineobject.hpp \
    src/engine.hpp \
    include/acknext.h \
    include/acknext/config.h \
    include/acknext/event.h \
    include/acknext/view.h \
    include/acknext/ackdef.h \
    include/acknext/ackvars.h \
    include/acknext/core.h \
    src/core/config.hpp \
    src/core/log.hpp \
    src/graphics/core.hpp \
    include/acknext/ackenum.h \
    src/input/inputmanager.hpp \
    include/acknext/input.h \
    include/acknext/keyboard-config.h \
    include/acknext/core-graphics.h \
    include/acknext/blob.h \
    src/core/blob.hpp \
    include/acknext/opengl.h \
    include/acknext/scene.h \
    include/acknext/filesys.h \
    include/acknext/scheduler.h \
    include/acknext/ackmath.h \
    include/acknext/ackentity.h \
    src/virtfs/physfsrwops.h \
    src/graphics/scene/ackglm.hpp

SOURCES += \
    src/graphics/opengl/buffer.cpp \
    src/graphics/opengl/shader.cpp \
    src/graphics/scene/material.cpp \
    src/graphics/scene/mesh.cpp \
    src/graphics/scene/stage.cpp \
    src/graphics/scene/pipeline.cpp \
    src/graphics/scene/model.cpp \
    src/graphics/scene/light.cpp \
    src/graphics/scene/camera.cpp \
    src/graphics/opengl/bitmap.cpp \
    src/scene/entity.cpp \
    src/collision/collision.cpp \
    src/collision/hull.cpp \
    src/graphics/core/view.cpp \
    src/events/event.cpp \
    src/input/gamepad.cpp \
    src/input/joystick.cpp \
    src/math/vector.cpp \
    src/math/var.cpp \
    src/core/init.cpp \
    src/core/config.cpp \
    src/core/log.cpp \
    src/core/errorhandling.cpp \
    src/graphics/core/graphics-core.cpp \
    src/core/globals.cpp \
    src/input/inputmanager.cpp \
    src/input/input-strings.cpp \
    src/core/blob.cpp \
    src/graphics/opengl/opengl.cpp \
    src/math/matrix.cpp \
    src/graphics/graphics-resource.cpp \
    src/virtfs/physfs-integration.cpp \
    src/scheduler/scheduler.cpp \
    src/virtfs/physfsrwops.c \
    src/math/quaternion.cpp \
    src/graphics/scene/scene-renderer.cpp
