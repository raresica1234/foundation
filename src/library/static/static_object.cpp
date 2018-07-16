#include "static_object.h"

void StaticObject::read(std::FILE* stream)
{
	std::fscanf(stream, "%d", &m_id);
}

void StaticObject::write(std::FILE* stream) const
{
	std::fprintf(stream, "%d", m_id);
}
