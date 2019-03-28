[![](https://images.microbadger.com/badges/image/f800r/checklink.svg)](https://microbadger.com/images/f800r/checklink) [![](https://images.microbadger.com/badges/version/f800r/checklink.svg)](https://microbadger.com/images/f800r/checklink)
# Dockerfile for W3C Link Checker - checklink

Dockerfile which wraps [w3c/link-checker](https://github.com/w3c/link-checker) project into a docker image.

## Build

```bash
docker build -t checklink:latest .
```

## View help

```bash
docker run -it --rm checklink
```

## Run a sample check

```bash
docker run -it --rm checklink --depth 0 https://www.google.com
```

## Sample run

```bash
docker run -it --rm checklink --version
W3C Link Checker version 4.81 (c) 1999-2011 W3C
```

## Based on the work of 

Thanks to 

- [@w3c](https://github.com/w3c/link-checker)
- [@stupchiy](https://github.com/stupchiy)
