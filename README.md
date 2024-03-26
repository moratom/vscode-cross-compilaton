# This is a small example to showcase how to setup a cross-compilation project with docker containers

The main idea is to have two containers:
- Development container with the cross-compilation toolchain on a native architecture where the code is developed
- Target container with the target architecture where the code will be executed
- [Optionally] A third container which already includes the compiled code of the project - this is generally not used for iteration during development but for deployment.


## Development cycle idea

1. Open vscode in the development container:
    * Ctrl+Shift+P -> Remote-Containers: Open Folder in Container -> Select the folder where the project is located **or**
    * Open the project in vscode and click on the bottom left corner on the green icon and select "Reopen in Container"
2. Select the target IP in the prompt
2. Develop the code (in this example change the main.cpp file)
3. Launch the code with [TODO - finish]