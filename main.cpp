#include <windows.h> 
#pragma comment(lib, "user32.lib")
#pragma comment(lib, "kernel32.lib") 
#pragma comment(linker, "/ENTRY:main")

int main() {
    MessageBoxA(NULL, "test message", "test message", MB_OK | MB_TOPMOST | MB_ICONINFORMATION);
    ExitProcess(0);
}
