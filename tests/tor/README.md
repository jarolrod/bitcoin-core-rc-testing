<div align="center">
  <h1>Bitcoin Core Release Candidate Testing: Tor Changes</h1>
  <p>
    Current Release Candidate:
    <a href="https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc2">
      Bitcoin Core 0.21rc2
    </a>
    <a href="https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft">
      (changelog)
    </a>
  </p>
</div>

Current nodes are limited to relaying addresses which fit into 128 bits. This limitation hinders Bitcoin nodes to a small set of network types. The upcoming Bitcoin Core release incorporates an implementation of [BIP 155](https://github.com/bitcoin/bips/blob/master/bip-0155.mediawiki) which introduces a new P2P message that allows network nodes to gossip addresses which are longer than 128 bits. This opens up the possibility of running nodes on new network types such as I2P and Tor V3.

**Why do we want to add compatibility for Tor v3 addresses?**

Tor v2 addresses contain various vulnerabilities which expose a node to a variety of [attacks](https://github.com/Attacks-on-Tor/Attacks-on-Tor). v2 addresses are also over a decade old, they are scheduled to be [retired](https://blog.torproject.org/v2-deprecation-timeline) by October 15, 2021. [Tor Onion v3](https://www.jamieweb.net/blog/onionv3-hidden-service/) addresses use a stronger ecryption format that fixes some of v2's weaknesses.

**What else do I need to know about this change?**

Accommodating for the new address sizes makes the `peers.dat` backwards-incompatible. A `peers.dat` file created with a 0.21 node will not be backwards compatible with a node <0.21.

## Install Tor
Tor must be installed on your system for the tor related tests to function properly. The script currently assumes that tor is running on the default UNIX port of 9050.

### MacOS Instructions
#### 1. Homebrew

The easiest way to install tor for MacOS is to use [homebrew](https://brew.sh/). This package manager allows you to easily install packages right from the command line.

To install homebrew (if not already installed):
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Install Tor
Now that homebrew is installed, lets install the tor package:
```
$ brew install tor
```
#### 3. Run Tor
```
$ tor
```

## Manual Testing
For those wanting to dig deeper, [Bitcoin Core provides documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md) on how to test running a node on Tor. There is little manual config to be done. In fact, on some linux distros if there is a tor daemon running on the machine bitcoind will pick it up and authenticate with a cookie file.

There are two setups that would equally valuable to test.
  - [Running a Bitcoin Core hidden server](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#2-run-a-bitcoin-core-hidden-server)
  - [Automatically listening on Tor](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#3-automatically-listen-on-tor)
