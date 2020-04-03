#ifndef ENTITY_HPP
#define ENTITY_HPP

#include "engine.hpp"

class Entity : public EngineObject<ENTITY>
{
public:
	static Entity * first;
	static Entity * last;
	Entity * previous;
	Entity * next;
public:
	MODEL * hullProvider;
public:
	Entity();
	NOCOPY(Entity);
	~Entity();

	void update();
};

#endif // ENTITY_HPP
