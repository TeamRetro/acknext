#pragma once

#include "ackcfg.h"

#if defined(__cplusplus)
extern "C"
{
#endif

/**
 * @brief An enumeration of flags that can be applied to
 *        engine objects. Some flags may be used only only
 *        on some objects or won't have any effect.
 */
enum FLAGS
{
    /**
     * @brief A flag that says that no flags are set.
     */
    NONE = 0,

    /**
     * @brief If set, the entity will be visible.
     **/
    VISIBLE = (1<<0),

    /**
     * @brief If set, the entity won't collide with other entities.
     **/
    PASSABLE = (1<<1),

    /**
     * @brief If set, the entity will not be touchable by the mouse.
     */
    UNTOUCHABLE = (1<<2),

    /**
     * @brief If set, the entity will cast a shadow.
     */
    SHADOW = (1<<3),

    /**
     * @brief Marks an entity as translucent and moves it to the
     *        translucent render pass.
     */
    TRANSLUCENT = (1<<4),
};

/**
 * @brief An enumeration of possible error values.
 */
enum ERROR
{
    /**
     * No error has happened.
     */
    SUCCESS = 0,

    /**
     * @brief The engine ran out of memory.
     */
    OUT_OF_MEMORY = 1,
};

struct ENTITY;

/**
 * @brief A level that contains a set of entities and some other settings.
 */
struct LEVEL
{
    /**
     * @brief The filename of this level.
     */
    char ACKCONST * ACKCONST filename;

    /**
     * @brief A pointer to a linked list of entities that will be created within this level.
     */
    struct ENTITY * ACKCONST entities;

    /**
     * @brief flags
     */
    enum FLAGS flags;
};



typedef struct LEVEL LEVEL;

typedef enum FLAGS FLAGS;

typedef enum ERROR ERROR;

#if defined(__cplusplus)
}
#endif
