# Public: specify the global node version as per nodenv
#
# Usage:
#
#   class { 'nodejs::global': version => '0.10.0' }

class nodejs::global($version = '0.10') {
  require nodejs

  ensure_resource('nodejs::version', $version)

  validate_re($version, '\A\d+\.\d+(\.\d+)*\z',
    'Version must be of the form N.N(.N)')

  file { "${nodejs::nodenv_root}/version":
    ensure  => present,
    owner   => $nodejs::nodenv_user,
    mode    => '0644',
    content => "${version}\n",
  }
}
