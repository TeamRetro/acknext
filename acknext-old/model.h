#ifndef MODEL_H
#define MODEL_H

#include <acknext.h>
#include <vector>
#include <ode/ode.h>
#include <ode/collision.h>

struct Model
{
	std::vector<MATERIAL> materials;
	std::vector<MESH> meshes;

	Model();
	~Model();
};

Model * model_get(char const * name);

#endif // MODEL_H