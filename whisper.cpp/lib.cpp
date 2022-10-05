#include <iostream> 
#include <string>
#include <cstring>
using std::string; 
extern "C" char* getString() {  
    char* ch = new char[11] /* 11 = len of Hello Heap + 1 char for \0*/;
    strcpy(ch, "Hello Heap");
    return ch;
}