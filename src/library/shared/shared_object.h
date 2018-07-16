#pragma once
#include <cstdio>

#ifdef _MSC_VER
# ifdef SHARED_LIB
#  define EXPORT __declspec(dllexport)
# else
#  define EXPORT __declspec(dllimport)
# endif
#else
# define EXPORT __attribute__((visibility("default")))
#endif

class EXPORT SharedObject
{
public:
	void read(std::FILE* stream);
	void write(std::FILE* stream) const;

private:
	int m_id;
};
