#include <iostream>
#include <vector>

int main() {
    std::cout << "Hello, World from ARM!" << std::endl;
    auto vec = std::vector<int>{1, 2, 3, 4, 5};
    for (auto i : vec) {
        std::cout << i << std::endl;
    }
    std::cout << "This was a test!" << std::endl;
    return 0;
}