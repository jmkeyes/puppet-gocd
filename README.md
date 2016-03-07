# Puppet GoCD Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/jmkeyes/gocd.svg)](https://forge.puppetlabs.com/jmkeyes/gocd)
[![Build Status](https://travis-ci.org/jmkeyes/puppet-gocd.svg?branch=master)](https://travis-ci.org/jmkeyes/puppet-gocd)

#### Table of Contents

 1. [Overview](#overview)
 2. [Description](#description)
 3. [Configuration](#configuration)
 4. [Examples](#examples)
 5. [Todo](#todo)
 6. [Contributors](#contributors)

## Overview

This is a Puppet Module to deploy and manage the ThoughtWorks GoCD server and agent(s).

## Description

This module contains two main classes:

  * `gocd::server` (GoCD Server)
  * `gocd::agent` (GoCD Agent)

## Configuration

### GoCD Server

To get up and running quickly with default settings, use `include '::gocd::server'`.

The defaults should set up a GoCD Server according to the setup guide.

Review the `gocd::server` class for options.

### GoCD Agent

To get a build agent up and running, provide the `server` parameter:

```
class { '::gocd::agent':
  server => 'gocd-server.example.net',
}
```

The deployed build agent will connect to `gocd-server.example.net` automatically.

## Examples

There are no examples to show yet.

## Todo

  * Windows/Solaris/OSX platforms and ZIP-based installation.
  * GoCD Server configuration via API if possible.
  * GoCD Server artifact directory management.
  * Fully support GoCD Agent auto-registration.

## Contributors

Thanks to the following people who have contributed to this module!

  * [Vlad Korolev](https://github.com/vladistan)
