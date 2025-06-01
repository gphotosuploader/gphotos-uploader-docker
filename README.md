# gphotos-uploader-docker
This project provides a Docker image for running the [gphotos-uploader-cli](https://github.com/gphotosuploader/gphotos-uploader-cli) tool, allowing you to upload media folders to your Google Photos account without installing anything on your personal computer.

> **Note:** This Docker image is intended for **local use only**. Headless devices are not supported at this time.

## Usage

You can run the container with:

```sh
docker run --rm -v /path/to/config:/config \
       -v /path/to/photos:/photos:ro \
       gphotos-uploader-docker
```

Replace `/path/to/config` and `/path/to/photos` with your local directories.

> Bear in mind that the configuration file should be configured with the `SourceFolder: /photos` value.

## Examples

### Authentication

To authenticate with Google Photos, you can run the container interactively:

```sh
docker run -it -v /path/to/config:/config \
       -v /path/to/photos:/photos:ro \
       -p 12345:12345 \
       gphotos-uploader-docker auth --port 12345 --local-bind-address 0.0.0.0
```

This command will start the authentication process, allowing you to open a web browser and complete the login.

### Uploading Photos
To upload photos, you can run the following command:

```sh
docker run -it -v /path/to/config:/config \
       -v /path/to/photos:/photos:ro \ 
       gphotos-uploader-docker push
```

This command will upload all photos from the `/path/to/photos` local directory to your Google Photos account.

## TODO

- [] Use local user instead of root in the docker (rootless setup)
- [] Ease commands to run
- [] Headless support


