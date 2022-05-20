# ARM compatible installation of @apllo/rover

Rover has no support for Linux/arm currently, so it has to be built from
scratch. The default rover NPM package doesn't support building from scratch,
so it breaks the installation. This is troublesome on Apple Silicon hardware if
you're building a Docker container.
