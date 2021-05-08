# Super Image
The super image is a template Docker project that can be used to quickly build an
image comprised of various modular utilities with unique install processes.

## Usage
To run an interactive session in the container, use the follow script:
```bash
scripts/run-standard
```

Or if you want to run a specific utility, you can use the following syntax:
```bash
scripts/run-standard [command] [args...]
```

If a utility requires a more specialized run script, it should be present in the
`scripts` directory and should be documented in a location like
`packages/example/README.md`.

## Build
To build the image, use the following script:
```bash
scripts/docker-build
```

## Structure
### `lib/`
This directory should be used for scripts directly involved in building this image.

### `lib/install-packages`
The primary hook-in for installing packages. Package install scripts must be added
to the `installers` array at the top of this file to be executed.

### `packages/`
This directory contains the desired packages to be installed along with their
install scripts.

### `packages/example/`
Small example package to be used as a model for installing your own packages.

### `scripts/`
Build and run scripts that should not be included in the image.