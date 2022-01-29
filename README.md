<p align="center">
  <h3 align="center">tailscale-ssl-proxy</h3>
  <p align="center">Simple single-command SSL reverse proxy for Tailscale<p>
</p>

A handy way to add Tailscale SSL support to your locally running thing -- be it your personal jupyter notebook, nodejs app or any other http application. 

`tailscale-ssl-proxy` uses the official <a href="https://pkg.go.dev/tailscale.com">Tailscale go package</a> to get trusted LetsEncrypt SSL certs and then proxies HTTPS traffic to your existing HTTP server in a single command. `tailscale-ssl-proxy` also redirects unencrypted HTTP traffic on port 80 to HTTPS.

## Installation

This will fetch the latest version of tailscale-ssl-proxy for your operating system and place it in `./bin/tailscale-ssl-proxy`

```sh
# Install the correct binary to ./bin
curl -L https://github.com/eastlondoner/tailscale-ssl-proxy/releases/download/v0.0.3/install-tailscale-ssl-proxy.sh | sh -s

```

Then add the binary to your PATH:

#### For most linux-based systems including Mac OS

Move the binary to `/usr/local/bin`

```sh
mv ./bin/tailscale-ssl-proxy /usr/local/bin
```

#### For Windows systems

TBC - need to figure out what the instructions for Windows systems are

## Quickstart

```sh
tailscale-ssl-proxy
# Proxying calls from https://:443 (SSL/TLS) to http://localhost:8080
```
This will immediately fetch, real LetsEncrypt certificates for the machine's Tailscale address.

## Usage

Print usage using the `-help` option

```sh
tailscale-ssl-proxy -help
```

```
Usage of tailscale-ssl-proxy
  -from string
    	the tcp address and port this proxy should listen for requests on (default ":443")
  -redirectHTTP string
    	the tcp address and port this proxy should listen for http->https request redirects. Set to 'off' to disable http->https redirect (default ":80")
  -to string
    	the address and port for which to proxy requests to (default "http://localhost:8080")
```

## Warning

The ssl certificate files (including the private key) are written to the current working directory as `cert.pem` and `key.pem` - that is the behaviour of the tailscale client. The private key is sensitive use at your own risk.

### Examples

#### Proxy to port 3000 (instead of 8080)

```sh
tailscale-ssl-proxy -to :3000
```

#### Disable HTTP -> HTTPS Redirect

```sh
tailscale-ssl-proxy -redirectHTTP off
```
Simply include the `-redirectHTTP` flag when running the program.

#### Serve https on port 8443 (instaead of 443)

```sh
tailscale-ssl-proxy -from 0.0.0.0:8443
```
Simply include the `-redirectHTTP` flag when running the program.

### Build from source 
#### Build from source using Docker
You can build `tailscale-ssl-proxy` for all platforms quickly using the included Docker configurations.

If you have `docker-compose` installed:
```sh
docker build . -t tailscale-ssl-proxy_build-release
docker-compose -f docker-compose.build.yml up
```
will build linux, osx, and darwin binaries (x86) and place them in a `build/` folder in your current working directory.

#### Build from source locally
You must have Golang installed on your system along with `make`. Then simply clone the repository and run `make`. 

## Attribution
Forked from <a href="https://github.com/suyashkumar/ssl-proxy">ssl-proxy by Suyash Kumar</a>
Icons made by <a href="https://www.flaticon.com/authors/those-icons" title="Those Icons">Those Icons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
