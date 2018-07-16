#pragma once
#include <cstdio>

class StaticObject
{
public:
	void read(std::FILE* stream);
	void write(std::FILE* stream) const;

private:
	int m_id;
};
