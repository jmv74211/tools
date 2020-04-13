#!/bin/bash

TARGET=""
VERSION=""
OS_VERSION=""
OS=""
SOURCES_PATH="${HOME}/utils/docker"

# -------------------------------------------------------------------------------------------------

function get_os_folder {

  case $1 in

    "amazonlinux")
      case $2 in
        "2")
          echo -n "AmazonLinux/2"
        ;;
        "1")
          echo -n "AmazonLinux/1"
        ;;
      esac
    ;;

    "centos")
      case $2 in
       "8")
          echo -n "CentOS/8"
        ;;
        "7")
          echo -n "CentOS/7"
        ;;
        "6")
          echo -n "CentOS/6"
        ;;
        "5")
          echo -n "CentOS/5"
        ;;
      esac
    ;;

    "debian")
      case $2 in
        "buster"|"Buster"|"10")
          echo -n "Debian/Buster"
        ;;
        "stretch"|"Stretch"|"9")
          echo -n "Debian/Stretch"
        ;;
        "jessie"|"Jessie"|"8")
          echo -n "Debian/Jessie"
        ;;
        "wheezy"|"Wheezy"|"7")
          echo -n "Debian/Wheezy"
        ;;
      esac
    ;;

    "fedora")
      case $2 in
        "31")
          echo -n "Fedora/31"
        ;;
        "30")
          echo -n "Fedora/30"
        ;;
        "29")
          echo -n "Fedora/29"
        ;;
        "28")
          echo -n "Fedora/28"
        ;;
        "27")
          echo -n "Fedora/27"
        ;;
        "26")
          echo -n "Fedora/26"
        ;;
        "25")
          echo -n "Fedora/25"
        ;;
        "24")
          echo -n "Fedora/24"
        ;;
        "23")
          echo -n "Fedora/23"
        ;;
        "22")
          echo -n "Fedora/22"
        ;;
      esac
    ;;

    "opensuse")
      case $2 in
        "tumbleweed")
          echo -n "OpenSuse/Thumbleweed"
        ;;
        "42")
          echo -n "OpenSuse/42"
        ;;
        "15")
          echo -n "OpenSuse/15"
        ;;
      esac
    ;;

    "oraclelinux")
      case $2 in
        "8")
          echo -n "OracleLinux/8"
        ;;
        "7")
          echo -n "OracleLinux/7"
        ;;
        "6")
          echo -n "OracleLinux/6"
        ;;
      esac
    ;;

    "redhat")
      case $2 in
        "8")
          echo -n "RedHat/8"
        ;;
        "7")
          echo -n "RedHat/7"
        ;;
        "6")
          echo -n "RedHat/6"
        ;;
      esac
    ;;

    "oraclelinux")
      case $2 in
        "8")
          echo -n "OracleLinux/8"
        ;;
        "7")
          echo -n "OracleLinux/7"
        ;;
        "6")
          echo -n "OracleLinux/6"
        ;;
      esac
    ;;

    "ubuntu")
      case $2 in
        "disco"|"Disco"|"19.04"|"19")
          echo -n "Ubuntu/Disco"
        ;;
        "cosmic"|"Cosmic"|"18.10")
          echo -n "Ubuntu/Cosmic"
        ;;
        "bionic"|"Bionic"|"18.04"|"18")
          echo -n "Ubuntu/Bionic"
        ;;
        "artful"|"Artful"|"17.10")
          echo -n "Ubuntu/Artful"
        ;;
        "zesty"|"Zesty"|"17.04"|"17")
          echo -n "Ubuntu/Zesty"
        ;;
        "yakkety"|"Yakkety"|"16.10")
          echo -n "Ubuntu/Yakkety"
        ;;
        "xenial"|"Xenial"|"16.04"|"16")
          echo -n "Ubuntu/Xenial"
        ;;
        "wily"|"Wily"|"15.10")
          echo -n "Ubuntu/Wily"
        ;;
        "vivid"|"Vivid"|"15.04"|"15")
          echo -n "Ubuntu/Vivid"
        ;;
        "trusty"|"Trusty"|"14.04"|"14")
          echo -n "Ubuntu/Trusty"
        ;;
        "precise"|"Precise"|"12.04"|"12")
          echo -n "Ubuntu/Precise"
        ;;
      esac
    ;;
  esac
}

# -------------------------------------------------------------------------------------------------

function help {
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "    -t, --target <manager|agent>   [Required] Select Wazuh target --> manager or agent"
    echo "    -o, --os <os_version>          [Required] Select OS and version. Example: centos_7, ubuntu_18."
    echo "    -v, --version <wazuh version>  [Required] Select Wazuh version. Example 3.12.2"
    echo "    -h, --help                     [Optional] Show this help."
    echo
    exit $1
}

# -------------------------------------------------------------------------------------------------

function download_sources {
  if [ ! -d $SOURCES_PATH ]; then
    mkdir -p $SOURCES_PATH
    git clone git@github.com:wazuh/wazuh-jenkins.git --depth=1 "${SOURCES_PATH}/wazuh"
    mv "${SOURCES_PATH}/wazuh/dockers/wazuh-slaves/" ${SOURCES_PATH}
    rm -rf "${SOURCES_PATH}/wazuh"
    mv "${SOURCES_PATH}/wazuh-slaves" "${SOURCES_PATH}/wazuh"
  fi

  echo "Sources are in ${SOURCES_PATH}"
}

# -------------------------------------------------------------------------------------------------

function build {
  docker build -t $1 --build-arg version=$2 $3
}

# -------------------------------------------------------------------------------------------------

function run {
  docker run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --rm -ti $1 bash
}

# -------------------------------------------------------------------------------------------------

function main {
    while [ -n "$1" ]
    do
        case "$1" in
        "-t"|"--target")
            if [ -n "$2" ]; then
                TARGET="$2"
                shift 2
            else
                help 1
            fi
            ;;
        "-v"|"--version")
            if [ -n "$2" ]; then
                VERSION=$(echo $2 | sed "s/v//")
                shift 2
            else
                help 1
            fi
            ;;
        "-o"|"--os")
            if [ -n "$2" ]; then
                OS=$(echo $2 | cut -d "_" -f 1)
                OS_VERSION=$(echo $2 | cut -d "_" -f 2)
                shift 2
            else
                help 1
            fi
            ;;
        "-h"|"--help")
            help 0
            ;;
        *)
            help 1
        esac
    done

    if [[ "${TARGET}" != "" ]] && [[ "${VERSION}" != "" ]] && [[ "${OS}" != "" ]] \
      && [[ "${OS_VERSION}" != "" ]]; then
      download_sources
      docker_path="${HOME}/utils/docker/wazuh/${TARGET}/$(get_os_folder $OS $OS_VERSION)"
      tag="${TARGET}_v${VERSION}_${OS}_${OS_VERSION}"
      build $tag $VERSION $docker_path
      run $tag
    else
      echo
      echo "Error: need required parameters"
      echo
      help 0
    fi
}

main "$@"