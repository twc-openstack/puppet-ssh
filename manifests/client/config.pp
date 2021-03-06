class ssh::client::config
{
  $options = $::ssh::client::merged_options

  file { $ssh::params::ssh_config:
    ensure  => present,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/ssh_config.erb"),
    require => Class['ssh::client::install'],
  }

  # Workaround for https://tickets.puppetlabs.com/browse/PUP-1177.
  # Fixed in Puppet 3.7.0
  if $::ssh::client::workaround_PUP1177 {
    ensure_resource('file', '/etc/ssh/ssh_known_hosts', {
      'ensure'  => 'file',
      'mode'    => '0644',
    })
  }
}
