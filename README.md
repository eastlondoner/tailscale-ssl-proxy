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
curl -L https://github.com/eastlondoner/tailscale-ssl-proxy/releases/download/v0.0.4/install-tailscale-ssl-proxy.sh | sh -s

```

Then add the binary to your PATH:

#### For most linux-based systems including Mac OS

Move the binary to `/usr/local/bin`

```sh
# Move the binary to /usr/local/bin
mv ./bin/tailscale-ssl-proxy /usr/local/bin
```

#### For Windows systems

TBC - need to figure out what the instructions for Windows systems are

## Quickstart

```sh
tailscale-ssl-proxy
# Listening on [::]:443
# Listening on [::]:80
# Proxying calls from https://:443 (SSL/TLS) to http://localhost:8080
# Redirecting http requests on :80 to https on port :443
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
# Listening on [::]:443
# Listening on [::]:80
# Proxying calls from https://:443 (SSL/TLS) to http://localhost:3000
# Redirecting http requests on :80 to https on port :443
```

#### Disable HTTP -> HTTPS Redirect

```sh
tailscale-ssl-proxy -redirectHTTP off
# Listening on [::]:443
# Proxying calls from https://:443 (SSL/TLS) to http://localhost:8080
```
Simply include the `-redirectHTTP` flag when running the program.

#### Serve https on port 8443 (instaead of 443)

```sh
tailscale-ssl-proxy -from 0.0.0.0:8443
# Listening on [::]:8443
# Listening on [::]:80
# Proxying calls from https://0.0.0.0:8443 (SSL/TLS) to http://localhost:8080
# WARN: You must serve on port :443 for the LetsEncrypt certs that tailscale uses to be valid
# Redirecting http requests on :80 to https on port :8443
```
Simply include the `-redirectHTTP` flag when running the program.

### Build from source 
#### Build from source using Docker
You can build `tailscale-ssl-proxy` for all platforms quickly using the included Docker configurations.

If you have `docker-compose` installed you can use the `./docker-make` script:
```sh
./docker-make build
```
That will build a binary for your local system and place it in the root directory.

#### Build from source locally
You must have Golang installed on your system along with `make`. Then simply clone the repository and run `make`. 

## Attribution
Forked from <a href="https://github.com/suyashkumar/ssl-proxy">ssl-proxy by Suyash Kumar</a>
