define postfix::main (  $ensure = present,
                        $value = undef,
                        $configfile = '/etc/postfix/main.cf' ) {

  case $ensure {
    present: {
      if $value == undef {
        fail("You have to provide a value for ${title}")
      }
      $action = 'set'
    }
    absent: {
      $action = 'rm'
    }
    default: { fail('Ensure can only be present or absent') }
  }

  if is_array($value) {
    $flatvalue = join($value,',')
  }
  else {
    $flatvalue = $value
  }

  augeas { "postfix-main-${title}":
    context => "/files${configfile}",
    incl    => $configfile,
    lens    => 'Postfix_Main.lns',
    changes => "${action} ${title} '${flatvalue}'"
  }
}
