#ifdef __ANDROID__
#include <android/log.h>
#else
#include <stdio.h>
#endif

template<typename... Args>
static void Print(const char* str, Args... args)
{
#ifdef __ANDROID__
	__android_log_print(ANDROID_LOG_INFO, "Project", str, args...);
#else
	printf(str, args...);
#endif
}

#ifdef _WIN32
static char s_platformString[] = "Windows";
#elif __ANDROID__
static char s_platformString[] = "Android";
#elif __linux__
static char s_platformString[] = "Linux";
#elif __APPLE__
static char s_platformString[] = "Mac OS X";
#else
static char s_platformString[] = "Unknown System";
#endif

void Main()
{
	Print("Hello, %s!", s_platformString);
}

/* Per-platform entry function */

#ifdef _WIN32
#include <windows.h>
int WINAPI WinMain(HINSTANCE /*instance*/, HINSTANCE /*prevInstance*/, LPSTR /*cmdLine*/, int /*showCmd*/)
{
	Main();
	return 0;
}
#elif __ANDROID__
#include <android_native_app_glue.h>
void android_main(struct android_app* /*state*/)
{
	Main();
}
#else
int main(int /*argc*/, char* /*argv*/[])
{
	Main();
	return 0;
}
#endif
