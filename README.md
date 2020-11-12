# pipeline-status

For generating netboot.xyz pipeline status

```
docker build -t localbuild -f Dockerfile-build .
docker run --rm -it -v $(pwd):/buildout localbuild
```
