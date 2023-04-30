#!/usr/bin/env bash
set -euo pipefail

USAGE=$(cat << EOF
Usage: docker-setup.sh [OPTIONS] [--] [VLAN]

Setup l3 ipvlan networks

OPTIONS:
  -i --ip-prefix <ipv4-prefix> IPv4 prefix to under which subnets are
                               created (default: 10.0)
  -p --parent         <parent> Parent interface (default: ens33)
  -s --swarm                   Enable swarm scope (default: disabled)
  -P --prefix         <prefix> Prefixed to the network's name, may be passed an
                               empty string (default: woodytoys-)
  -S --suffix         <suffix> Suffixed to the network's name, may be passed an
                               empty string (default: -l3ipvlan)

VLANS: <vlan>=<n-subnet>
  vlan: Vlan name
  n-subnet: Number of subnet to generate

EOF
)

function error() {
  if [ -v 1 ]; then
    echo -e "---\nERROR: $1\n---" >&2
  else
    error "Unspecified"
  fi
}

nw_scope="local"
nw_name_prefix="woodytoys"
nw_name_suffix="l3ipvlan"
nw_parent_interface="ens33"
nw_ip4_prefix="10.0"
nw_ip4_suffix="0"

declare -A pos_args
pos_args=()

while [ -v 1 ]; do
  arg="$1"
  case $1 in
    -i|--ip-prefix)
      if [ -z "${2:-}" ]; then
        echo "$USAGE" >&2
        error "$1 specified but no <ipv4-prefix> given"
        exit 1
      fi
      shift

      ;;
    -p|--parent)
      if [ -z "${2:-}" ]; then
        echo "$USAGE" >&2
        error "$1 specified but no <parent> given"
        exit 1
      fi
      shift
      parent_interface="$1"
      ;;
    -s|--swarm)
      nw_scope="swarm"
      ;;
    -P|--prefix)
      if [ -z "${2:-}" ]; then
        echo "$USAGE" >&2
        error "$1 specified but no <prefix> given"
        exit 1
      fi
      shift
      nw_name_prefix="$1"
      ;;
    -S|--suffix)
      if [ -z "${2:-}" ]; then
        echo "$USAGE" >&2
        error "$1 specified but no <suffix> given"
        exit 1
      fi
      shift
      nw_name_suffix="$1"
      ;;
    --)
      shift
      while [ -v 1 ]; do
        n_args=${#pos_args[@]}
        pos_args[$n_args]="$1"
        shift
      done
      ;;
    -*|--*)
        echo "$USAGE" >&2
        error "Unrecognized option: $1"
        exit 1
      ;;
    *)
      n_args=${#pos_args[@]}
      pos_args[$n_args]="$1"
  esac
  shift || true
done

nw_ipvlan_opt=(
  "-o" "parent=$nw_parent_interface"
  "-o" "ipvlan_mode=l3"
)
docker_nw_opt=(
  "--scope" "$scope"
)

for arg in ${pos_args[@]}; do
  if [ -v nw_name ] || [ -v nw_n_subnets ]; then
    error "Multiple vlans specified"
    exit 1
  fi
  case "$arg" in
    *=*)
      nw_name=$(echo $arg | sed 's/=.*//')
      nw_n_subnets=$(echo $arg | sed 's/^[^=]\+=//')
      case $nw_name in
        ''|*[!a-z]*)
          echo "$USAGE" >&2
          error "<vlan> must be lowercase ascii letters: $nw_name"
          exit 1
          ;;
        *)
          ;;
      esac
      case $nw_n_subnets in
        ''|*[!0-9]*)
          echo "$USAGE" >&2
          error "<n-subnets> must be an integer: $nw_n_subnets"
          exit 1
          ;;
        *)
          if [ "$nw_n_subnets" -gt 255 ]; then
            error "Too many subnets in ipvlan network $nw_vlan: $nw_n_subnets"
            exit 1
          fi
          ;;
      esac
      ;;
    *)
      echo "$USAGE" >&2
      error "Expected <vlan>=<n-subnets>, got: $arg"
      exit 1
      ;;
  esac
done

if ! $([ -v nw_name ] || [ -v nw_n_subnets ]); then
  echo "No vlan specified, nothing to do" >&2
  exit 0
fi

subnets_opt=$(
  seq 0 $(($nw_n_subnets - 1)) \
  | sed "s/^\(.*\)$/--subnet $nw_ip4_prefix.&.0\/24/"
)
docker network create \
  ${docker_nw_opt[@]} \
  -d ipvlan \
  ${nw_ipvlan_opt[@]} \
  ${subnets_opt[@]} \
  "$nw_name_prefix-$nw_name-$nw_name_suffix"

