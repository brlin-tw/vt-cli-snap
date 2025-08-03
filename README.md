# Unofficial snap packaging for the VirusTotal Command Line Interface

Provides easy-to-install snap package for [the VirusTotal Command Line Interface](https://virustotal.github.io/vt-cli/).

<https://gitlab.com/brlin/vt-cli-snap>  
[![The GitLab CI pipeline status badge of the project's `main` branch](https://gitlab.com/brlin/vt-cli-snap/badges/main/pipeline.svg?ignore_skipped=true "Click here to check out the comprehensive status of the GitLab CI pipelines")](https://gitlab.com/brlin/vt-cli-snap/-/pipelines) [![GitHub Actions workflow status badge](https://github.com/brlin-tw/vt-cli-snap/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/vt-cli-snap/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/gitlab.com/brlin/vt-cli-snap "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/gitlab.com/brlin/vt-cli-snap)

\#snap-packaging

## References

The following materials are referenced during the development of this project:

* [VirusTotal/vt-cli: VirusTotal Command Line Interface](https://github.com/VirusTotal/vt-cli)  
  The project of the packaged software.
* [Craft a Go app - Snapcraft documentation](https://documentation.ubuntu.com/snapcraft/stable/how-to/integrations/craft-a-go-app/)  
  For general information about how to package a Go application to snap format.
* [YAML anchors | Bitbucket Cloud | Atlassian Support](https://support.atlassian.com/bitbucket-cloud/docs/yaml-anchors/)  
  Explains how to use YAML anchors to avoid repeating the same content in the `snapcraft.yaml` file.
* [snapcraft.yaml - Snapcraft documentation](https://documentation.ubuntu.com/snapcraft/stable/reference/project-file/snapcraft-yaml/)  
  For the documentation of the top-level fields in the `snapcraft.yaml` file.
* [The personal-files interface - doc - snapcraft.io](https://forum.snapcraft.io/t/the-personal-files-interface/9357)  
  For the documentation of the `personal-files` snapd security confinement interface, which is used to import the native configuration file to the snap's data directory.
* [Permission requests | Snapcraft documentation](https://snapcraft.io/docs/permission-requests)  
  [Process for aliases, auto-connections and tracks | Snapcraft documentation](https://snapcraft.io/docs/process-for-aliases-auto-connections-and-tracks)  
  For general information about how to request special permissions from the Snap Store.

## Licensing

Unless otherwise noted([comment headers](https://reuse.software/spec-3.3/#comment-headers)/[REUSE.toml](https://reuse.software/spec-3.3/#reusetoml)), this product is licensed under [the 2.0 version of the Apache License license](https://www.apache.org/licenses/LICENSE-2.0), or any of its more recent versions of your preference.

This work complies to [the REUSE Specification](https://reuse.software/spec/), refer to the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.
