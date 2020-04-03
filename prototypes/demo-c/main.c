#include <acknext.h>

static ENTITY * rotor;

void gameloop(void*arg);

void gamemain()
{
    // Provide a default scene rendering
    view_create((RENDERCALL)render_scene_with_camera, camera);

    LIGHT * sun = light_create(SUNLIGHT);
    sun->direction = *vec_normalize(vector(0.6, -1, -0.4), 1.0);
    sun->color = *color_hex(0xfffac1);

    LIGHT * ambi = light_create(AMBIENTLIGHT);
    ambi->color = *color_hex(0x232c33);

    rotor = ent_create("/builtin/models/cube.amd", vector(0, 0, -64), NULL);

    event_attach(on_update, gameloop);
}

void gameloop(void*arg)
{
    QUATERNION q;
    quat_axis_angle(&q, vector(0, 1, 0), 16.0f * time_step);
    quat_mult(&rotor->rotation, &q);
}
