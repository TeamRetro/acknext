TEMPLATE = lib
CONFIG += c++11
CONFIG -= app_bundle
CONFIG -= qt

unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += ode sdl2 SDL2_image SDL2_mixer zlib assimp gl
}

QMAKE_CFLAGS += -fsanitize=undefined
QMAKE_CXXFLAGS += -fsanitize=undefined
QMAKE_LFLAGS += -fsanitize=undefined

include($$PWD/../extern/gl3w/gl3w.pri)

INCLUDEPATH += $$PWD/include
INCLUDEPATH += $$PWD/src

DEPENDPATH += $$PWD/include
DEPENDPATH += $$PWD/src

INCLUDEPATH += $$PWD/../extern/stb/include

LIBS += -lphysfs

DEFINES += _ACKNEXT_INTERNAL_

#
#custom_rcc.output  = resource.o
#custom_rcc.commands = /usr/bin/make /../resource/ qmake OUTFILE=`pwd`/${QMAKE_FILE_OUT} shaders
#custom_rcc.depend_command = /usr/bin/make -C $$PWD/../resource/ depends
#custom_rcc.input = RESOURCES
#QMAKE_EXTRA_COMPILERS += custom_rcc

LIBS += /home/felix/projects/acknext/resource/resource.o

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
    include/acknext/ackmath.h \
    include/acknext/ackentity.h \
    src/graphics/scene/ackglm.hpp \
    include/acknext/acktransforms.h \
    src/graphics/debug/debugdrawer.hpp \
    include/acknext/ackdebug.h \
    include/acknext/ackcol.h \
    src/collision/collisionsystem.hpp \
    src/audio/audiomanager.hpp \
    src/audio/sound.hpp \
    include/acknext/acksound.h \
    src/virtfs/resourcemanager.hpp \
    src/graphics/opengl/uniformconfig.h \
    include/acknext/extension.h \
    include/acknext/serialization.h \
    src/extensions/extension.hpp \
    src/graphics/core/glenum-translator.hpp \
    include/acknext/acff.h \
    src/scene/animation.hpp \
    src/graphics/shareddata.hpp \
    src/graphics/opengl/framebuffer.hpp

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
  src/graphics/stb_image.cpp \
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
src/virtfs/physfs-integration.cpp \
src/math/quaternion.cpp \
src/graphics/scene/scene-renderer.cpp \
src/math/transforms.cpp \
src/graphics/debug/debugdrawer.cpp \
src/collision/collisionsystem.cpp \
src/audio/audiomanager.cpp \
src/audio/sound.cpp \
src/virtfs/resourcemanager.cpp \
src/math/color.cpp \
src/graphics/opengl/programuniform.cpp \
src/core/blob_compression.c \
src/core/engineobject.cpp \
src/extensions/extension.cpp \
src/virtfs/serialization.cpp \
src/core/guid.cpp \
src/serialization/serializers.cpp \
src/graphics/core/glenum-translator.cpp \
src/virtfs/ackfile.cpp \
src/scene/animation.cpp \
src/graphics/opengl/framebuffer.cpp \
src/math/aabb.cpp

RESOURCES += \
    $$TOPDIR/resource/builtin.qrc

DISTFILES += \
    acknext.pri

