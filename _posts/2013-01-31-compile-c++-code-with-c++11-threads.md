# Compile C++ code with C++11 threads

Consider the following code, which uses the C++11 (used to be known as C++0x) thread library:

    #include <iostream>
    #include <thread>

    using namespace std;

    void hello_world()
    {
      cout << "Hello from thread!\n";
    }

    int main()
    {
      thread t(hello_world);
      t.join();
      return 0;
    }

How can we get this to work? If we compile it with:

    g++ bare.cpp -o bare

We'll get something like:

    /usr/include/c++/4.5/bits/c++0x_warning.h:31:2: error: #error This file requires compiler and library support for the upcoming ISO C++ standard, C++0x. This support is currently experimental, and must be enabled with the -std=c++0x or -std=gnu++0x compiler options.

... and maybe something about the `thread` type used in the code:

    error: ‘thread’ was not declared in this scope

So we add the `std=c++0x` ...

    g++ bare.cpp -std=c++0x -o bare

No errors during compilation, but when we try to execute `bare`...

    $ ./bare
    terminate called after throwing an instance of 'std::system_error'
      what():  
    Aborted

... oops. We have to link this against the operating system's implementation of threads. In linux, this is the `libpthread` library. The winning command is:

    g++ bare.cpp -std=c++0x -lpthread -o bare

and then:

    $ ./bare
    Hello from thread!
