class postfix::params {
  case $::osfamily {
    'RedHat': {
      $seltype = $::operatingsystemmajrelease ? {
        '4'   => 'etc_t',
        /5|6/ => 'postfix_etc_t',
        default => undef,
      }
    }

    'Fedora': {
      $seltype = $::operatingsystemmajrelease ? {
        '20' => 'postfix_etc_t',
        default => undef,
      }
    }

    'Debian': {
      $seltype = undef
    }

    'Suse': {
      $seltype = undef
    }

    default: {
      fail "Unsupported OS family '${::osfamily}'"
    }
  }
}
