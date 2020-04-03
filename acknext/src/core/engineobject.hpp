#ifndef ENGINEOBJECT_HPP
#define ENGINEOBJECT_HPP

#include <GL/gl3w.h>

#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include <map>
#include <string>

#include <acknext.h>

extern "C" void engine_log(char const *format, ...);

union Value {
	int ints[4];
	uint uints[4];
	float floats[4];
	bool bools[4];
	MATRIX matrices[4];
	BITMAP *texture;
	void *pointer;
};

struct Property
{
	Property() : type(GL_NONE) {}

	explicit Property(GLenum type, Value const &value);

	void set(GLenum type, Value const &value);

	GLenum type;
	Value data;

	bool isSampler() const { return isSampler(this->type); }
	static bool isSampler(GLenum type);
};

extern "C" void obj_listvar(void const *);

class BaseEngineObject
{
	friend void obj_listvar(void const *);

public:
	const uint32_t magic;
	mutable std::map<std::string, Property> properties;

protected:
	explicit BaseEngineObject();
	virtual ~BaseEngineObject();

public:
	void removeProperty(std::string const &name);

	void setProperty(std::string const &name, Property const &value);

	Property const &getProperty(std::string const &name) const;
};

template <typename T>
class EngineObject : public BaseEngineObject
{
public:
	typedef T cdataType;
	static const ptrdiff_t cdataOffset = sizeof(EngineObject<T> *);

private:
	T *cdata;

public:
	explicit EngineObject() : cdata(nullptr)
	{
		uintptr_t ptr = reinterpret_cast<uintptr_t>(malloc(cdataOffset + sizeof(T)));
		EngineObject<T> **ref = reinterpret_cast<EngineObject<T> **>(ptr);
		*ref = this;
		this->cdata = reinterpret_cast<T *>(ptr + cdataOffset);
		// Initialize with explicit zeroes :)
		memset(this->cdata, 0, sizeof(T));
	}

	EngineObject(EngineObject const &) = delete;
	EngineObject(EngineObject &&) = default;

	virtual ~EngineObject()
	{
		uintptr_t ptr = reinterpret_cast<uintptr_t>(this->cdata);
		ptr -= cdataOffset;
		free(reinterpret_cast<void *>(ptr));
	}

	T const &api() const { return *this->cdata; }
	T &api() { return *this->cdata; }
};

// A dummy structure
struct DUMMY
{
};
struct Dummy : public EngineObject<DUMMY>
{
};

template <typename T>
static inline T *promote(typename T::cdataType *value)
{
	if (value != nullptr)
	{
		uintptr_t ptr = reinterpret_cast<uintptr_t>(value);
		ptr -= T::cdataOffset;
		EngineObject<typename T::cdataType> **obj = reinterpret_cast<EngineObject<typename T::cdataType> **>(ptr);
		T *result = static_cast<T *>(*obj);
		if (result->magic != 0xBADC0DED)
		{ // when this crashes or fails, an invalid object was passed
			engine_log("promote<T> received a non-engine object (%08X)!", result->magic);
			abort();
		}
		return result;
	}
	else
	{
		return nullptr;
	}
}

template <typename T>
static inline T const *promote(typename T::cdataType const *value)
{
	return const_cast<T const *>(promote<T>(const_cast<typename T::cdataType *>(value)));
}

template <typename T>
static inline T *demote(EngineObject<T> *value)
{
	if (value != nullptr)
	{
		return &value->api();
	}
	else
	{
		return nullptr;
	}
}

#endif // ENGINEOBJECT_HPP
