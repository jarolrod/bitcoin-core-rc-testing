# Testing Guide: Bitcoin Core 0.21 Release Candidate
This document outlines some of the upcoming Bitcoin Core 0.21 release changes and provides steps on how to test these changes.

## Introduction

The release candidate for version 0.21 was just tagged and is ready for testing. And, oh boy, is 0.21 the right time for you to get involved as a contributor. It’s jam-packed with changes that need to be run on your operating system with your hardware. Database changes? Welcome [SQLite](https://github.com/bitcoin/bitcoin/pull/19077). A new network to test on? Hello, [signet](https://github.com/bitcoin/bitcoin/pull/18267). Have you heard that Tor v2 is being deprecated? The upgrade to [Tor v3](http://github.com/bitcoin/bitcoin/pull/19954) is in 0.21. What about the wallet? [Total re-write](https://achow101.com/2020/10/0.21-wallets).

You can get involved by running through this guide and checking that everything works as it should on your machine. Please report back your findings [here](https://github.com/bitcoin/bitcoin/issues/20555). If everything went smoothly, let us know. If everything broke, definitely let us know!

## Preparation
#### 1. Grab Latest Release Candidate
**Current Release Candidate:** [Bitcoin Core 0.21rc3](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3) [(changelog)](https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft)

There are two ways to grab the latest release candidate: pre-compiled binary or source code.
The source code for the latest release can be grabbed from here: [latest release source code](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3).

If you want to use a binary, make sure to grab the correct one for your system. There are individual binaries for [Linux](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-x86_64-linux-gnu.tar.gz), [Arm (64 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-aarch64-linux-gnu.tar.gz), [Arm (32 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-arm-linux-gnueabihf.tar.gz), and [RISC-V](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-riscv64-linux-gnu.tar.gz).

macOS users will need to either compile from source or use the [rc2 binary](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-osx.dmg) until we can figure out Apple's code signing issue.

#### 2. Compile Release Candidate

**If you grabbed a binary, skip this step.**

Before compiling, make sure that your system has all the right dependencies installed. As this guide utilizes the Bitcoin Core GUI, you must compile support for the GUI and have the `qt5` dependency already installed. To test the new wallet changes, make sure that you installed the `sqlite3` dependency. Here are some guides to compile Bitcoin Core from source for [OSX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md), [Windows](https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md), [FreeBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-freebsd.md), [NetBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-netbsd.md), [OpenBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-openbsd.md), and [UNIX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md).

---
## Testing Wallet Changes
The Bitcoin Core 0.21 release introduces sweeping changes to the wallet to move towards a well-designed wallet, capable of full-utilization of Bitcoin. This release introduces [descriptor wallets](https://diyhpl.us/wiki/transcripts/advancing-bitcoin/2020/2020-02-06-andrew-chow-descriptor-wallets/), a new type of wallet that generates addresses from [descriptors](https://bitcoinops.org/en/topics/output-script-descriptors/) instead of private keys. Tied together with this new wallet type is a new [SQLite](https://www.sqlite.org/index.html) database that aims to replace the aging [BerkeleyDB 4.8](https://blogs.oracle.com/berkeleydb/berkeley-db-48) database currently used.

**What's wrong with the current (legacy) wallets?**

The current wallet was designed when what Bitcoin could be used for was not yet fully understood. This led to a wallet design language that focused on maintaining a collection of [private keys](https://en.bitcoin.it/wiki/Private_key). As Bitcoin has progressed, this design language has held back the wallet from fully utilizing the expressiveness of [Bitcoin Script](https://en.bitcoin.it/wiki/Script). New features have had to be hacked on to the wallet.

**Why the Switch to SQlite?**

As mentioned; The current wallet uses `BerkelyDB 4.8`, which is 10 years old. This database is not actively maintained, not meant to be used as an application database, and is susceptible to file corruptions. Since the move to descriptor wallets introducing breaking compatibility changes,

SQLite was chosen as a new database because it provides certain guarantees necessary for ensuring that the wallet remains backwards compatible moving forward. Furthermore, unlike `BerkelyDB 4.8`, SQLite allows us to have a one file wallet instead of a wallet directory. This helps with wallet portability.

### 1. Preparation
If you grabbed the binary for this release candidate, you're good to go. If you went down the source route, it is required that you installed the `sqlite3` dependency and compiled the source code with wallet functionality. Skip this section if you intentionally do not want wallet functionality or don't want to test it.

### 2. Manual Testing

##### 1. Create a new data directory
We will be creating and supplying a new data directory for our node to run from. Starting from the root of your Bitcoin release candidate directory, run:

``` bash
mkdir 21-rc-test
```
##### 2. Run node, provide data directory
We will now run `bitcoin-qt` and provide a data directory:

###### Source code

``` bash
./src/qt/bitcoin-qt --datadir=./21-rc-test
```

###### Binary
``` bash
./bin/bitcoin-qt --datadir=./21-rc-test
```
##### 3. Create new Descriptor Wallet

###### New Default Behavior
Upon start, a node no longer creates a wallet by default. We will need to create a new wallet. If you are starting up a node for the first time or using a fresh data directory (as we are), you will be met with the following screen:

![new wallet intro](https://imgur.com/4UlP090.png)

###### Create New Wallet
Clicking on "Create a new Wallet" will bring you to the following screen. Give your wallet a name and make sure to have `Descriptor Wallet` enabled under `Advanced Options`. Congratulations, You've created your first descriptor wallet!

![descriptor](https://imgur.com/xIuT09U.png)

##### 4. Check for `wallet.dat`
First, shut down your node. Then, navigate to your wallet's data directory and ensure that a `wallets.dat` file has been created under a directory with the value you supplied as `Wallet Name`. In the case of this example, it is `my-descriptor-wallet`. You should see something like this:

![wallet-dat](https://imgur.com/w9mzT7q.png)

---

## Testing Torv3

Current nodes are limited to relaying addresses that fit into 128 bits. This limitation hinders Bitcoin nodes to a small set of network types. The upcoming Bitcoin Core release incorporates an implementation of [BIP 155](https://github.com/bitcoin/bips/blob/master/bip-0155.mediawiki), which introduces a new P2P message that allows network nodes to gossip addresses that are longer than 128 bits. This opens up the possibility of running nodes on new network types such as I2P and Tor V3.

**Why do we want to add compatibility for Tor v3 addresses?**

Tor v2 addresses contain various vulnerabilities that expose a node to a variety of [attacks](https://github.com/Attacks-on-Tor/Attacks-on-Tor). V2 addresses are also over a decade old, and they are scheduled to be [retired](https://blog.torproject.org/v2-deprecation-timeline) by October 15, 2021. [Tor Onion v3](https://www.jamieweb.net/blog/onionv3-hidden-service/) addresses use a stronger encryption format that fixes some of v2's weaknesses.

**What else do I need to know about this change?**

Accommodating for the new address sizes makes the `peers.dat` backwards incompatible. A `peers.dat` file created with a 0.21 node will not be backwards compatible with a node <0.21.

### 1. Preparation
Tor must be installed on your system for the Tor related tests to function properly. The script currently assumes that Tor is running on the default UNIX port of 9050. Below are some guides to setting up the `tor` package on your system.

#### macOS Instructions

##### 1. Homebrew
The easiest way to install `tor` for MacOS is to use [homebrew](https://brew.sh/). This package manager allows you to easily install packages right from the command line easily.

To install homebrew (if not already installed):
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

##### 2. Install Tor
Now that homebrew is installed, let's install the `tor` package:
```
$ brew install tor
```
##### 3. Run Tor
```
$ tor
```

### 2. Manual Testing
For those wanting to dig deeper, [Bitcoin Core provides documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md) on how to test running a node on Tor. There is little manual config to be done. In fact, on some linux distros, if there is a Tor daemon running on the machine, `bitcoind` will pick it up and authenticate with a cookie file.

#### Listen on TorV3
We are going to setup our node to [listen on Tor automatically](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#3-automatically-listen-on-tor). This means that the node is going to look for other peers on the Tor network.

##### 1. Create bitcoin.conf
The `bitcoin.conf` file is used to [configure](https://en.bitcoin.it/wiki/Running_Bitcoin#Bitcoin.conf_Configuration_File) how your node will run. This file is not automatically created and must be created manually. This file will be created in the data directory that we previously created while testing the wallet. From your data directory, run:

``` bash
touch bitcoin.conf
```
##### 2. Edit bitcoin.conf
We will be adding settings to the bitcoin.conf that will allow us to connect and find peers through the Tor network. Since the Bitcoin Core 0.21 release has not actually been released yet, `Torv3` nodes are rare to come across. Because of this, we are going to manually add a `Torv3` node that has been tracked down. Using your favorite text editor, add the following to the newly created `bitcoin.conf` file:

```
proxy=127.0.0.1:9050 #If you use Windows, this could possibly be 127.0.0.1:9150 in some cases.
listen=1
bind=127.0.0.1
onlynet=onion

addnode=sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd.onion:8333
addnode=rp7k2go3s5lyj3fnj6zn62ktarlrsft2ohlsxkyd7v3e3idqyptvread.onion:8333
```

(Cutting an pasting the text above should do the trick, but you can see the [example bitcoin.conf](https://github.com/bitcoin/bitcoin/blob/master/share/examples/bitcoin.conf) file for an overview of the available options.

##### 3a. Start bitcoind

```bash
./src/bitcoind --datadir=./21-rc-test
```

You will see a flurry of messages as the logs pass by. Open a new terminal window and let's query our running node to see who we've connected to:

```bash
./src/bitcoin-cli --datadir=./21-rc-test getpeerinfo
```

This should show you a list of peers. This is what a first one might look like:
```bash
[
  {
    "id": 0,
    "addr": "rp7k2go3s5lyj3fnj6zn62ktarlrsft2ohlsxkyd7v3e3idqyptvread.onion:8333",
    ...
    "network": "onion",
    ...
  }
]
```

If you have "rp7k2go3s5lyj3fnj6zn62ktarlrsft2ohlsxkyd7v3e3idqyptvread" or "sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd" in the response, you've successfully connected to a Tor v3 node! :tada:

##### 3b. Launch bitcoin-qt

Launch `bitcoin-qt` and provide the data directory we have been using:

###### Source code

``` bash
./src/qt/bitcoin-qt --datadir=./21-rc-test
```

###### Binary
``` bash
./bin/bitcoin-qt --datadir=./21-rc-test
```

##### 4. Check for Tor peers
###### Navigate to Peers Window
Navigate to and click on `Window->Peers` to bring up information on the connected Peers.
![Window->Peers](https://imgur.com/gONbuA7.png)

###### Visually Examine Peer Information
You can differentiate a Torv3 node from a Torv2 node by looking at how long it is. A Torv3 node is 56 characters long and always ends in a `d` such as: `sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd.onion`. A Torv2 node is 16 characters long, such as: `uovsp2yltnaojq6l.onion:8333`. Your Peer window should look something like this:

![torv3-peers](https://imgur.com/ISzPLKe.png)

---

## Testing Signet
The Bitcoin [testnet](https://en.bitcoin.it/wiki/Testnet) is a proof-of-work based testing framework where volunteers are relied on to mine blocks with real CPU power and in turn receive worthless `testnet` coins. Since the economics of the `mainnet` are not at play here, we get a network that is unpredictable and, frustratingly, unreliable.

This release introduces [Signet](https://bitcoinops.org/en/topics/signet/), a new testing network. Signet does away with decentralized proof-of-work in favor of a centralized consensus mechanism where a group with authority is in charge of creating new blocks based on valid signatures. The aim is to create a testing network that is predictable and reliable.

## 1. Manual Testing
The [Bitcoin Wiki](https://en.bitcoin.it/wiki/Signet) contains excellent documentation on connecting to and testing Signet.

---

## Testing Anchors
An [eclipse attack](https://cs-people.bu.edu/heilman/eclipse/) is an attack on bitcoin's p2p network. In order for the attack to be effective, the attacker aims to restart your node and then supply your node with IP addresses controlled by the attacker. Eclipse attacks reduce the soundness of second layer solutions such as the lightning network.

When you're node connects to the Bitcoin network, it makes [two outbound block-relay-only connections](https://github.com/bitcoin/bitcoin/pull/15759). This release introduces [Anchor Connections](https://github.com/bitcoin/bitcoin/pull/17428). Anchors are the two outbound block-relay connections] your node is connected to; logged to an `anchors.dat` file so that they can be used upon a node restart. Under the assumption that you were connected to honest nodes before the attack, this aims to reduce an eclipse attack from being successful.

### 1. Manual Testing
When a node shuts down cleanly, then an `anchors.dat` file should appear in the node's data directory. We want to check that this file is created upon node shut-down, and deleted on node start-up.

#### 1. Clean up data directory
We want to delete the `bitcoin.conf` in our data directory as we no longer need to connect through Tor. You're free to leave this in if you like. In the data directory do:
``` bash
rm ./bitcoin.conf
```

#### 2. Start up your node through bitcoin-qt
Start your node however you do so. If the release candidate is integrated into your desktop environment or is packaged into a `.dmg` in the case of macOS, launch `bitcoin-qt` from your application launcher. Otherwise, starting from the root directory of your binary or source download, run:

``` bash
./src/qt/bitcoin-qt
```
#### 3. Navigate to Peers Window
Navigate to and click on `Window->Peers` to bring up information on the connected Peers.
![Window->Peers](https://imgur.com/gONbuA7.png)

#### 4. Confirm Peer connections
At the peer information page, visually check that you are connected to peers.
![peers](https://imgur.com/7M6AW6D.png)

#### 5. Shut down your node
Shut down your node by navigating and clicking on File->Exit.
![shut-down](https://imgur.com/GSgvHhc.png)

#### 6. Check for an `anchors.dat` file
Navigate to the data directory for your node.
![check-anchorsdat](https://imgur.com/AOCnuZ4.png)

#### 7. Restart node and check that `anchors.dat` is removed
Restart your node, then navigate to your data directory. The image below is the data directory for a Bitcoin node while it is running. Notice that the `anchors.dat` file is missing. This is the expected behavior.
![anchor-gone](https://imgur.com/tydZLxa.png)
