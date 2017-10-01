#include <acknext.h>
#include <acknext/serialization.h>
#include <zlib.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <GL/gl3w.h>

#include <stdlib.h>

#include <assert.h>

#include <default.h>
#include <terrainmodule.h>

// #include <ackcef.h>
#include <ackgui.h>

#ifdef _ACKNEXT_EXT_ACKCEF_H_
VIEW * cefview;
static const bool enableCEF = true;
#endif

#define	GL_TEXTURE_MAX_ANISOTROPY_EXT          0x84FE
#define	GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT      0x84FF


void funnylight()
{
	LIGHT * funlight = light_create(SPOTLIGHT);
	funlight->color = COLOR_WHITE;
	funlight->intensity = 25.0;
	funlight->arc = 40;
	funlight->position = camera->position;
	funlight->direction = *vec_rotate(vector(0,0,-1), &camera->rotation);

	while(true)
	{
		draw_point3d(&funlight->position, &COLOR_RED);
		draw_line3d(
			&funlight->position,
			vec_add(
				vec_clone(&funlight->position),
				vec_normalize(vec_clone(&funlight->direction), 10)),
			&COLOR_GREEN);
		task_yield();
	}
}

ENTITY * terrain;
SHADER * shdtree;

void spawn(const int radius, const int count, char const * fileName, float scale)
{
	const VECTOR center = camera->position;
	for(int i = 0; i < count; i++)
	{
		VECTOR off;
		off.x = center.x + (rand() / (float)RAND_MAX) * 2*radius - radius;
		off.z = center.z + (rand() / (float)RAND_MAX) * 2*radius - radius;
		off.y = terrain_getheight(terrain->model, off.x, off.z) - 0.2;
		ENTITY * tree = ent_create(fileName, &off, NULL);
		quat_axis_angle(&tree->rotation, vector(0,1,0), 360 * (float)rand() / (float)RAND_MAX);
		vec_fill(&tree->scale, scale);
	}
}

void tree()
{
	spawn(250, 250, "/models/tree.amd", 1.0);
}

void grass()
{
	spawn(50, 500, "/models/grass.amd", 0.4);
}

ENTITY * player;

void outsider()
{
	static float time_step_over_time = 0;
	static float gpu_time_over_time = 0;

	time_step_over_time = 0.9 * time_step_over_time + 0.1 * time_step;
	gpu_time_over_time = 0.9 * gpu_time_over_time + 0.1 * engine_stats.gpuTime;

	int num = 0;
	ENTITY * you;
	for(you = ent_next(NULL); you; you = ent_next(you), num++);

#ifdef _ACKNEXT_EXT_ACKCEF_H_
	char buffer[128];
	sprintf(buffer,
		"update(%.2f,%f,%d,%d)",
		camera->position.y,
		time_step_over_time,
		num,
		engine_stats.drawcalls);

	ackcef_exec(cefview, buffer);
#endif

#ifdef _ACKNEXT_EXT_ACKGUI_H_
	if(ImGui::Begin("Stats"))
	{
		ImGui::Text(
			"Camera Pos: (%.2f, %.2f, %.2f)",
			camera->position.x,
			camera->position.y,
			camera->position.z);
		ImGui::Text(
			"Framerate:  %d FPS",
			int(1.0 / time_step_over_time));
		ImGui::Text(
			"Frame Time: %4.2f ms",
			1000.0 * time_step_over_time);
		ImGui::Text(
			"GPU Time:   %4.2f ms",
			gpu_time_over_time);
		ImGui::Text(
			"Entities:   %d",
			num);
		ImGui::Text(
			"Drawcalls:  %d",
			engine_stats.drawcalls);
	}
	ImGui::End();

	if(ImGui::Begin("Camera / Player"))
	{
		ImGui::Text("Camera:");
		if(ImGui::Button("Save##Camera"))
		{
			ACKFILE * file = file_open_write("camera.dat");
			file_write(file, camera, sizeof(CAMERA));
			file_close(file);
		}
		ImGui::SameLine();
		if(ImGui::Button("Load##Camera"))
		{
			ACKFILE * file = file_open_read("camera.dat");
			file_read(file, camera, sizeof(CAMERA));
			file_close(file);
		}

		ImGui::Separator();

		ImGui::Text("Player:");
		if(ImGui::Button("Save##Player"))
		{
			ACKFILE * file = file_open_write("player.dat");
			file_write_vector(file, player->position);
			file_close(file);
		}
		ImGui::SameLine();
		if(ImGui::Button("Load##Player"))
		{
			ACKFILE * file = file_open_read("player.dat");
			player->position = file_read_vector(file);
			file_close(file);
		}
	}
	ImGui::End();
#endif
}

bool nightmode = false;

static void toggle_nightmode()
{
	nightmode ^= true;
}

void gamemain()
{
	GLfloat fLargest;
	glGetFloatv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, &fLargest);
	engine_log("max anisotropy: %f", fLargest);

	view_create((RENDERCALL)render_scene_with_camera, camera);
	filesys_addResource("/home/felix/projects/acknext/prototypes/project-z/resources/", "/");
	filesys_addResource("/home/felix/projects/acknext/scripts/", "/other/");


	shdtree = shader_create();

//	if(shader_addFileSource(shdtree, VERTEXSHADER, "/builtin/shaders/object.vert") == false) {
	if(shader_addFileSource(shdtree, VERTEXSHADER, "/shaders/fastobject.vert") == false) {
		abort();
	}
//	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/shaders/fastobject.frag") == false) {
	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/builtin/shaders/object.frag") == false) {
		abort();
	}
	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/builtin/shaders/lighting.glsl") == false) {
		abort();
	}
	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/builtin/shaders/gamma.glsl") == false) {
		abort();
	}
	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/builtin/shaders/ackpbr.glsl") == false) {
		abort();
	}
	if(shader_addFileSource(shdtree, FRAGMENTSHADER, "/builtin/shaders/fog.glsl") == false) {
		abort();
	}
	if(shader_link(shdtree) == false) {
		abort();
	}


#ifdef _ACKNEXT_EXT_ACKCEF_H_
	cefview = ackcef_createView();

	ackcef_navigate(cefview, "ack:///fungui.htm");

	while(!ackcef_ready(cefview))
	{
		task_yield();
	}

	ackcef_exec(cefview, "initialize()");
#endif

#ifdef _ACKNEXT_EXT_ACKGUI_H_
	ackgui_init();
#endif

	event_attach(on_t, (EVENTHANDLER)tree);
	event_attach(on_g, (EVENTHANDLER)grass);
	event_attach(on_l, (EVENTHANDLER)funnylight);
	event_attach(on_n, (EVENTHANDLER)toggle_nightmode);

	terrainmodule_init();
	default_init();
	default_speedup = 500;

	{
		ACKFILE * file = file_open_read("camera.dat");
		if(file) {
			file_read(file, camera, sizeof(CAMERA));
			file_close(file);
		}
	}

	terrain = ent_create("/terrain/GrassyMountains.terrain", vector(0,0,0), NULL);

	LIGHT * sun = light_create(SUNLIGHT);
	sun->direction = *vec_normalize(vector(0.6, -1, -0.4), 1.0);
	sun->color = *color_hex(0xfffac1);

	LIGHT * ambi = light_create(AMBIENTLIGHT);
	ambi->color = *color_hex(0x232c33);

	LIGHT * plambilight = light_create(POINTLIGHT);
	plambilight->intensity = 2;
	vec_fill((VECTOR*)&plambilight->color, 0.3);

	tree();

	player = ent_create("/other/cyber-pirate/cyber-pirate.amd", vector(0, 0, 512), NULL);
	vec_fill(&player->scale, 0.15);


	ACKFILE * file = file_open_read("player.dat");
	if(file) {
		player->position = file_read_vector(file);
		file_close(file);
	}

	var pan = 0;
	var tilt = 0;
	var camdist = 5;
	while(true)
	{
		if(nightmode) {
			sun->color = COLOR_BLACK;
			ambi->color = *color_hex(0x090b0d);
		} else {
			sun->color = *color_hex(0xfffac1);
			ambi->color = *color_hex(0x232c33);
		}

		if(key_3 && default_camera_movement_enabled)
		{
			player->position = camera->position;
		}

		if(!default_camera_movement_enabled)
		{
			pan -= 0.3 * mickey.x;
			tilt = clamp(tilt - 0.3 * mickey.y, -80, 85);
			camdist = clamp(camdist - 0.5 * mickey.w, 2.0, 10.0);

			camera->rotation = *euler(pan, tilt, 0);

			VECTOR mov = {
				float(key_d - key_a),
				0,
				float(key_s - key_w),
			};

			vec_normalize(&mov, (3 + 3 * key_lshift) * time_step);
			vec_rotate(&mov, euler(pan, 0, 0));
			vec_add(&player->position, &mov);

			if(vec_length(&mov) > 0.0)
			{
				var offset = atan2(mov.x, mov.z);
				player->rotation = *euler(RAD_TO_DEG * offset, 0, 0);

				if(key_lshift)
					ent_animate(player, "Run", total_time);
				else
					ent_animate(player, "Walk", total_time);
			}
			else
			{
				ent_animate(player, "Idle", total_time);
			}

			player->position.y = terrain_getheight(terrain->model, player->position.x, player->position.z);

			camera->position = (VECTOR) { 0, 0, camdist };
			vec_rotate(&camera->position, &camera->rotation);
			vec_add(&camera->position, &player->position);
			vec_add(&camera->position, vector(0, 1.5, 0));

			var mincam = terrain_getheight(terrain->model, camera->position.x, camera->position.z) + 0.2;
			if(camera->position.y < mincam)
				camera->position.y = mincam;

			vec_lerp(
				&plambilight->position,
				&player->position,
				&camera->position,
				0.4);
		}


		if(key_4) {
			static float gpuTime = 0.0;
			static float frameTime = 0.0;

			gpuTime = 0.9 * gpuTime + 0.1 * engine_stats.gpuTime;
			frameTime = 0.9 * frameTime + 0.1 * time_step;

			int num = 0;
			ENTITY * you;
			for(you = ent_next(NULL); you; you = ent_next(you), num++);

			engine_log(
				"%8.4f ms / %8.4f ms GPU Time / %5d Objects / %5d Drawcalls / %8.4f FPS",
				1000.0 * frameTime,
				gpuTime,
				num,
				engine_stats.drawcalls,
				1.0 / frameTime);
		}

		outsider();
		task_yield();
	}
}

int main(int argc, char ** argv)
{
	// May not return!
#ifdef _ACKNEXT_EXT_ACKCEF_H_
	ackcef_init(argc, argv);
#endif

	assert(argc >= 1);
	engine_config.argv0 = argv[0];
	return engine_main(gamemain);
}
