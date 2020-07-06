# codimd

[![Build Status](https://travis-ci.com/baurmatt/puppet-codimd.svg?branch=master)](https://travis-ci.com/baurmatt/puppet-codimd)
[![Puppet Forge](https://img.shields.io/puppetforge/v/baurmatt/codimd.svg)](https://forge.puppetlabs.com/baurmatt/codimd)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/baurmatt/codimd.svg)](https://forge.puppetlabs.com/baurmatt/codimd)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/baurmatt/codimd.svg)](https://forge.puppetlabs.com/baurmatt/codimd)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/baurmatt/codimd.svg)](https://forge.puppetlabs.com/baurmatt/codimd)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with codimd](#setup)
    * [What codimd affects](#what-codimd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with codimd](#beginning-with-codimd)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This module installs and configure CodiMD. It's inspired by the [puppet-etherpad](https://forge.puppetlabs.com/puppet/etherpad) module.

## Setup

### What codimd affects

 * This module depends on [puppet-nodejs](https://forge.puppetlabs.com/puppet/nodejs)
 * It also depends on [puppetlabs-vcsrepo](https://forge.puppetlabs.com/puppetlabs/vcsrepo) and hence git
 * It will setup a service using systemd
 * It will install all npm dependencies and keep them in sync on updates
 * It will also run db migration automatically on updates

### Setup Requirements

This module requires a database. Though it can use sqlite, it's recommend to use PostgreSQL or MySQL. See CodiMD offical documentation for further advice.

### Beginning with codimd

Before to installation, a target database should exist. Please consult the
documentation of
[puppetlabs-postgresql](https://forge.puppetlabs.com/puppetlabs/postgresql), or
[puppetlabs-mysql](https://forge.puppetlabs.com/puppetlabs/mysql) for how to
create those.

## Usage

The basic usage is:

```puppet
class { 'codimd':
  config => {
    host   => 'localhost',
    domain => 'codimd.example.org',
    db     => {
      username => 'codimd',
      password => 'mySuperSecurePassword',
      database => 'codimd',
      host     => '127.0.0.1',
      port     => 3306,
      dialect  => 'mysql',
    },
  },
}
```

Pin the version if you don't like automatic updates

```puppet
class { 'codimd':
  config  => {
  ...
  },
  version => '1.5.0',
}
```

## Reference

For information on the classes and types, see the [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-stdlib/blob/master/REFERENCE.md).

## Limitations

* Only systemd is supported as Service provider.
* Most things are currently hardcoded.
* Module is only tested on Ubuntu 18.04

PRs are very welcome! :)

## Development

This module is development with the help of [pdk](https://puppet.com/docs/pdk/1.x/pdk.html).

Please follow the standard Puppet development processes as lived by Puppetlabs/Vox Pupuli.

