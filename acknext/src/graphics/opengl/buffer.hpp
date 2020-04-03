#ifndef BUFFER_HPP
#define BUFFER_HPP

#include "engine.hpp"

class Buffer : public EngineObject<BUFFER>
{
public:
	explicit Buffer(GLenum type);
	NOCOPY(Buffer);
	~Buffer();
};

#endif // BUFFER_HPP
