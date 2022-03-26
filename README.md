This image extends the [terra-jupyter-r](https://github.com/DataBiosphere/terra-docker/blob/master/terra-jupyter-r/README.md) notebook with:

- bcftools
- samtools
- vg
- GNU time (use with `env time` or `/usr/local/bin/time`)

## Build

```sh
docker build -t jmonlong-terra-notebook-custom .
```

## Run locally

```sh 
docker run --rm -it -p 8000:8000 jmonlong-terra-notebook-custom
```

Then open [http://localhost:8000/notebooks](http://localhost:8000/notebooks).

## Push to DockerHub

```sh
docker tag jmonlong-terra-notebook-custom jmonlong/terra-notebook-custom:0.0.2
docker push jmonlong/terra-notebook-custom:0.0.2
```

Images at [jmonlong/terra-noteboook-custom](https://hub.docker.com/repository/docker/jmonlong/terra-noteboook-custom/general).
