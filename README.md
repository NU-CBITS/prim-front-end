# PRIM Front End

[![Build Status](https://travis-ci.org/cbitstech/prim-front-end.svg?branch=master)](https://travis-ci.org/cbitstech/prim-front-end) [![security](https://hakiri.io/github/cbitstech/prim-front-end/master.svg)](https://hakiri.io/github/cbitstech/prim-front-end/master)

Prim front end is a simple enrollment web application, designed to collect
information for users that wish to take part in various studies.

## Configuring to authenticate with PRIM Resources

You will need to generate an API Consumer record for PRIM Resources. The
instructions are in the README for that repository. Next, add the token to
the PRIM Front End configuration in `config/environments/[your env].rb`:

```ruby
config.prim_resources_token = 'your token'
```
