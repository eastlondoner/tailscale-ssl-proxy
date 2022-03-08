# Development

## With docker

To create a make target using docker you can use `docker-make <target name>`

For example to create all artifacts run
```
docker-make build-all
```

# Creating a release

Run `release.sh <version>` to create a release.

e.g.
```
./release.sh v0.0.6
```