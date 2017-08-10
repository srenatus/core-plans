pkg_name=telegraf
pkg_origin=core
pkg_version="1.3.5"
pkg_license=('MIT')
pkg_description="telegraf - client for InfluxDB"
pkg_upstream_url="https://github.com/influxdata/telegraf/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_scaffolding="core/scaffolding-go"
pkg_svc_run="telegraf --config $pkg_svc_config_path/telegraf.conf"
pkg_bin_dirs=(bin)

do_prepare() {
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_download() {
  mkdir -p "${GOPATH}"
  pushd "${GOPATH}" > /dev/null
  build_line "Downloading telegraf go package (github repository)"
  go get github.com/influxdata/telegraf
  popd > /dev/null
}

do_verify() {
  return 0
}

do_unpack() {
  pushd "${GOPATH}/src/github.com/influxdata/telegraf" > /dev/null
  build_line "Checking out telegraf version ${pkg_version} git tag"
  git checkout ${pkg_version}
  popd > /dev/null
}

do_build() {
  pushd "${GOPATH}/src/github.com/influxdata/telegraf" > /dev/null
  make
  popd > /dev/null
}

do_install() {
  install -vD "${GOPATH}/bin/telegraf" "${pkg_prefix}/bin"
}

do_clean() {
  return 0
}
