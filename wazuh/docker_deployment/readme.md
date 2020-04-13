# Deploy wazuh with docker

Deploy any version of wazuh on a large number of linux systems

## USAGE

```
Usage: ./deploy.sh [OPTIONS]

    -t, --target <manager|agent>   [Required] Select Wazuh target --> manager or agent
    -o, --os <os_version>          [Required] Select OS and version. Example: centos_7, ubuntu_18.
    -v, --version <wazuh version>  [Required] Select Wazuh version. Example 3.12.2
    -h, --help                     [Optional] Show this help.
```

**Example**

```
./deploy.sh -t manager -o ubuntu_18 -v 3.12.2
```

```
./deploy.sh -t agent -o centos_8 -v 3.12.0
```

## SUPPORTED OS

- **Ubuntu**: Disco(19.04), cosmic(18.10), bionic(18.04), artful(17.10), zesty(17.04), yakkety(16.10), xenial(16.04), wily(15.10), vivid(15.04), trusty(14.04), precise(12.04)

- **CentOS**: 8, 7, 6, 5

- **Debian**: Buster(10), Stretch(9), Jessie(8), Wheezy(7)

- **Fedora**: 31, 30, 29, 28, 27, 26, 25, 24, 23, 22

- **Amazon Linux**: 2, 1

- **RHEL**: 8, 7, 6

- **Oracle Linux**: 8, 7, 6

- **OpenSuse**: Tumbleweed, 42, 15
