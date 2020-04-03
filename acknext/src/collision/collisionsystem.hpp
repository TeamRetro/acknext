#ifndef COLLISIONSYSTEM_HPP
#define COLLISIONSYSTEM_HPP

#include "engine.hpp"

#include <ode/ode.h>
#include <ode/collision.h>

class CollisionSystem
{
public:
	CollisionSystem() = delete;

	static void initialize();

	static void update();

	static void draw();

	static void shutdown();
};

#endif // COLLISIONSYSTEM_HPP
