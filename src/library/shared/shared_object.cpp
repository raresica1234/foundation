#include "shared_object.h"

void SharedObject::read(std::FILE* stream)
{
	std::fscanf(stream, "%d", &m_id);
}

void SharedObject::write(std::FILE* stream) const
{
	std::fprintf(stream, "%d", m_id);
}
