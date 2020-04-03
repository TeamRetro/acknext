#include <acknext.h>
#include <stdio.h>

static ENTITY *rotor;

void gameloop(void *arg);

void gamemain()
{
  // Provide a default scene rendering
  view_create(render_scene_with_camera, camera);

  pp_stages &= ~PP_SSAO; // remove  default SSAO

  // Create a sun light
  LIGHT *sun = light_create(SUNLIGHT);
  sun->direction = *vec_normalize(vector(0.6, -1, -0.4), 1.0);
  sun->color = *color_hex(0xfffac1);

  // Create basic ambient light
  LIGHT *ambi = light_create(AMBIENTLIGHT);
  ambi->color = *color_hex(0x232c33);

  // Spawn a cube
  rotor = ent_create("/builtin/models/cube.amd", vector(0, 0, -64), NULL);

  // Call gameloop every frame
  event_attach(on_update, gameloop);
}

void gameloop(void *arg)
{
  // Calculate rotation and rotate our entity
  QUATERNION q;
  quat_axis_angle(&q, vector(0, 1, 0), 16.0f * time_step);
  quat_mult(&rotor->rotation, &q);
}

int main(int argc, char **argv)
{
  engine_config.argv0 = argv[0];
  return engine_main(gamemain);
}