# Cole's Lab Server OS

## Workflows

### build.yml

This workflow creates your custom OCI image and publishes it to the Github Container Registry (GHCR). By default, the image name will match the Github repository name.

### build-disk.yml

This workflow creates a disk images from your OCI image by utilizing the [bootc-image-builder](https://osbuild.org/docs/bootc/). In order to use this workflow you must complete the following steps:

- Modify `disk_config/iso.toml` to point to your custom container image before generating an ISO image.
- If you changed your image name from the default in `build.yml` then in the `build-disk.yml` file edit the `IMAGE_REGISTRY`, `IMAGE_NAME` and `DEFAULT_TAG` environment variables with the correct values. If you did not make changes, skip this step.
- Finally, if you want to upload your disk images to S3 then you will need to add your S3 configuration to the repository's Action secrets. This can be found by going to your repository settings, under `Secrets and Variables` -> `Actions`. You will need to add the following
  - `S3_PROVIDER` - Must match one of the values from the [supported list](https://rclone.org/s3/)
  - `S3_BUCKET_NAME` - Your unique bucket name
  - `S3_ACCESS_KEY_ID` - It is recommended that you make a separate key just for this workflow
  - `S3_SECRET_ACCESS_KEY` - See above.
  - `S3_REGION` - The region your bucket lives in. If you do not know then set this value to `auto`.
  - `S3_ENDPOINT` - This value will be specific to the bucket as well.

Once the workflow is done, you'll find the disk images either in your S3 bucket or as part of the summary under `Artifacts` after the workflow is completed.

### Justfile Documentation

This `Justfile` contains various commands and configurations for building and managing container images and virtual machine images using Podman and other utilities.

#### Environment Variables

- `image_name`: The name of the image (default: "image-template").
- `default_tag`: The default tag for the image (default: "latest").
- `bib_image`: The Bootc Image Builder (BIB) image (default: "quay.io/centos-bootc/bootc-image-builder:latest").

#### Aliases

- `build-vm`: Alias for `build-qcow2`.
- `rebuild-vm`: Alias for `rebuild-qcow2`.
- `run-vm`: Alias for `run-vm-qcow2`.

#### Commands

###### `check`

Checks the syntax of all `.just` files and the `Justfile`.

###### `fix`

Fixes the syntax of all `.just` files and the `Justfile`.

###### `clean`

Cleans the repository by removing build artifacts.

##### Build Commands

###### `build`

Builds a container image using Podman.

```bash
just build $target_image $tag
```

Arguments:
- `$target_image`: The tag you want to apply to the image (default: `$image_name`).
- `$tag`: The tag for the image (default: `$default_tag`).

##### Building Virtual Machines and ISOs

###### `build-qcow2`

Builds a QCOW2 virtual machine image.

```bash
just build-qcow2 $target_image $tag
```

###### `build-raw`

Builds a RAW virtual machine image.

```bash
just build-raw $target_image $tag
```

###### `build-iso`

Builds an ISO virtual machine image.

```bash
just build-iso $target_image $tag
```

###### `rebuild-qcow2`

Rebuilds a QCOW2 virtual machine image.

```bash
just rebuild-qcow2 $target_image $tag
```

###### `rebuild-raw`

Rebuilds a RAW virtual machine image.

```bash
just rebuild-raw $target_image $tag
```

###### `rebuild-iso`

Rebuilds an ISO virtual machine image.

```bash
just rebuild-iso $target_image $tag
```

##### Run Virtual Machines

###### `run-vm-qcow2`

Runs a virtual machine from a QCOW2 image.

```bash
just run-vm-qcow2 $target_image $tag
```

###### `run-vm-raw`

Runs a virtual machine from a RAW image.

```bash
just run-vm-raw $target_image $tag
```

###### `run-vm-iso`

Runs a virtual machine from an ISO.

```bash
just run-vm-iso $target_image $tag
```

###### `spawn-vm`

Runs a virtual machine using systemd-vmspawn.

```bash
just spawn-vm rebuild="0" type="qcow2" ram="6G"
```

##### Lint and Format

###### `lint`

Runs shell check on all Bash scripts.

###### `format`

Runs shfmt on all Bash scripts.
