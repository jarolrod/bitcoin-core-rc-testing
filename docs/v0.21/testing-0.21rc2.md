# Testing Guide: Bitcoin Core 0.21 Release Candidate

This document outlines some of the changes in the upcoming Bitcoin Core 0.21 release and steps on how to test these releases.

## Introduction

The release candidate for version 0.21 was just tagged and is ready for testing. And, oh boy, is 0.21 the right time for you to get involved as a contributor. It’s jam-packed with changes that need to be run on your operating system with your hardware. Database changes? Welcome [SQLite](https://github.com/bitcoin/bitcoin/pull/19077). A new network to test on? Hello, [signet](https://github.com/bitcoin/bitcoin/pull/18267). Have you heard that Tor v2 is being deprecated? The [upgrade to Tor v3](http://github.com/bitcoin/bitcoin/pull/19954) is in 0.21. What about the wallet? [Total re-write](https://achow101.com/2020/10/0.21-wallets).

You can get involved by running through this guide and checking that everything works as it should on your machine. Please report back your findings [here](https://github.com/bitcoin/bitcoin/issues/20555). If everything went smoothly, let us know. If everything broke, definitely let us know!

## Preparation
#### 1. Grab Latest Release Candidate
**Current Release Candidate:** [Bitcoin Core 0.21rc3](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3) [(changelog)](https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft)

There are two ways to grab the latest release candidate: pre-compiled binary or source code.
The source code for the latest release can be grabbed from here: [latest release source code](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3).

If you want to use a binary, make sure to grab the correct one for your system. There are individual binaries for [MacOS](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-osx.dmg), [Linux](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-x86_64-linux-gnu.tar.gz), [Arm (64 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-aarch64-linux-gnu.tar.gz), [Arm (32 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-arm-linux-gnueabihf.tar.gz), and [RISC-V](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-riscv64-linux-gnu.tar.gz).

#### 2. Compile Release Candidate

**Note: If you grabbed a binary, you can skip this step.**

Before compiling, make sure that your system has all the right dependencies installed. Here are some guides to compile Bitcoin Core from source for [OSX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md), [Windows](https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md), [FreeBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-freebsd.md), [NetBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-netbsd.md), [OpenBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-openbsd.md), and [UNIX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md).

---
## Testing Wallet Changes
The Bitcoin Core 0.21 release introduces sweeping changes to the wallet to move towards a well-designed wallet capable of full-utilization of Bitcoin. This release introduces [descriptor wallets](https://diyhpl.us/wiki/transcripts/advancing-bitcoin/2020/2020-02-06-andrew-chow-descriptor-wallets/), a new type of wallet that generates addresses from [descriptors](https://bitcoinops.org/en/topics/output-script-descriptors/) instead of private keys. Tied together with this new wallet type is a new [SQLite](https://www.sqlite.org/index.html) database that aims to replace the aging [BerkeleyDB 4.8](https://blogs.oracle.com/berkeleydb/berkeley-db-48) database currently used.

**What's wrong with the current (legacy) wallets?**

The current wallet was designed when what Bitcoin could be used for was not yet fully understood. This led to a wallet design language that focused on maintaining a collection of [private keys](https://en.bitcoin.it/wiki/Private_key). As Bitcoin has progressed, this design language has held back the wallet from fully utilizing the expressiveness of [Bitcoin Script](https://en.bitcoin.it/wiki/Script). New features have had to be hacked on to the wallet.

**Why the Switch to SQlite?**

As mentioned; The current wallet uses `BerkelyDB 4.8`, which is 10 years old. This database is not actively maintained, not meant to be used as an application database, and is susceptible to file corruptions. Since the move to descriptor wallets introducing breaking compatibility changes,

SQLite was chosen as a new database because it provides certain guarantees necessary for ensuring that the wallet remains backwards compatible moving forward. Furthermore, unlike `BerkelyDB 4.8`, SQlite allows us to have a one file wallet instead of a wallet directory.

### 1. Preparation
If you grabbed the binary for this release candidate, you're good to go. If you went down the source route, it is required that you installed the `sqlite3` dependency and compiled the source code with wallet functionality. Skip this section if you intentionally do not want wallet functionality or don't want to test it. This guide will be split between using the GUI and the CLI. Follow whichever you are comfortable using.

### 2. Manual Testing

#### 1. Create new Descriptor Wallet
##### New Default Behavior
Upon start, a node no longer creates a wallet by default. We will need to create a new wallet. If you are starting up a node for the first time or using a fresh data directory, you will be met with the following screen.

![new wallet intro](https://imgur.com/4UlP090.png)

##### Create a New Wallet
Clicking on "Create a new Wallet" will bring you to the following screen. Give your wallet a name and make sure to have `Descriptor Wallet` enabled under `Advanced Options`. You've created your first descriptor wallet!

![descriptor](https://imgur.com/xIuT09U.png)

##### Check for `wallet.dat`
Navigate to your wallet's data directory and ensure that a `wallets.dat` file has been created.



---

## Testing Torv3

Current nodes are limited to relaying addresses that fit into 128 bits. This limitation hinders Bitcoin nodes to a small set of network types. The upcoming Bitcoin Core release incorporates an implementation of [BIP 155](https://github.com/bitcoin/bips/blob/master/bip-0155.mediawiki), which introduces a new P2P message that allows network nodes to gossip addresses that are longer than 128 bits. This opens up the possibility of running nodes on new network types such as I2P and Tor V3.

**Why do we want to add compatibility for Tor v3 addresses?**

Tor v2 addresses contain various vulnerabilities that expose a node to a variety of [attacks](https://github.com/Attacks-on-Tor/Attacks-on-Tor). V2 addresses are also over a decade old and are scheduled to be [retired](https://blog.torproject.org/v2-deprecation-timeline) by October 15, 2021. [Tor Onion v3](https://www.jamieweb.net/blog/onionv3-hidden-service/) addresses use a stronger encryption format that fixes some of v2's weaknesses.

**What else do I need to know about this change?**

Accommodating for the new address sizes makes the `peers.dat` backwards incompatible. A `peers.dat` file created with a 0.21 node will not be backwards compatible with a node <0.21.

### 1. Preparation
Tor must be installed on your system for the Tor related tests to function properly. The script currently assumes that Tor is running on the default UNIX port of 9050. Below are some guides to setting up the `tor` package on your system.


#### macOS Instructions

##### 1. Homebrew
The easiest way to install `tor` for MacOS is to use [homebrew](https://brew.sh/). This package manager allows you to install packages right from the command line easily.

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
For those wanting to dig deeper, [Bitcoin Core provides documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md) on how to test running a node on Tor. There is little manual config to be done. In fact, on some Linux distros, if there is a Tor daemon running on the machine bitcoind will pick it up and authenticate with a cookie file.

#### Manual Testing with GUI

#### Listen on torv3
We are going to set up our node to [listen on Tor automatically](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#3-automatically-listen-on-tor). This means that the node is going to look for other peers on the Tor network.

---

## Testing Signet
The Bitcoin [testnet](https://en.bitcoin.it/wiki/Testnet) is a [proof-of-work](https://en.bitcoin.it/wiki/Proof_of_work) based testing framework where volunteers are relied on to [mine](https://en.bitcoin.it/wiki/Mining) [blocks](https://en.bitcoin.it/wiki/Block) with real CPU power and in turn receive worthless testnet coins. Since the economics of mainnet are not at play here, we get a network that is unpredictable and, frustratingly, unreliable.

This release introduces [Signet](https://bitcoinops.org/en/topics/signet/), a new testing network. Signet does away with decentralized proof-of-work in favor of a centralized consensus mechanism where a group with authority is in charge of creating new blocks based on valid signatures. The aim is to create a testing network that is predictable and reliable.

## 1. Manual Testing
The [Bitcoin Wiki](https://en.bitcoin.it/wiki/Main_Page) contains excellent documentation on connecting to and testing Signet. Follow this [guide](https://en.bitcoin.it/wiki/Signet) to test Signet.

---

## Testing Anchors
An [eclipse attack](https://cs-people.bu.edu/heilman/eclipse/) is an attack on bitcoin's p2p network. In order for the attack to be effective, the attacker aims to restart your node and then supply your node with IP addresses controlled by the attacker. Eclipse attacks reduce the soundness of second layer solutions such as the lightning network.

When your node connects to the Bitcoin network, it makes at least [two outbound block-relay only connections](https://github.com/bitcoin/bitcoin/pull/15759). This release introduces [Anchor Connections](https://github.com/bitcoin/bitcoin/pull/17428). Anchors are the [two outbound block-relay connections]() your node is connected to, logged to an `anchors.dat` file so that they can be used upon a node restart. Under the assumption that you were connected to honest nodes before the attack, this aims to reduce an eclipse attack from being successful.

### 1. Manual Testing
When a node shuts down cleanly, then an `anchors.dat` file should appear in the node's data directory. We want to check that this file is created upon node shut-down and deleted on node start-up. This guide will be split between using the GUI and the CLI. Follow whichever you are comfortable using.

#### Manual Testing with GUI

##### 1. Start up your node through bitcoin-qt
Start your node however you do so.

##### 2. Navigate to Peers Window
Navigate to and click on Window->Peers to bring up information on the connected Peers.
![Window->Peers](https://imgur.com/kHq8NFD.png)

##### 3. Confirm Peer connections
At the peer information page, visually check that you are connected to peers.
![peers](https://imgur.com/7M6AW6D.png)

##### 4. Shut down your node
Shut down your node by navigating and clicking on File->Exit.
![shut-down](https://imgur.com/ceiJanF.png)

##### 5. Check for an `anchors.dat` File
Navigate to the data directory for your node.
![check-anchorsdat](https://imgur.com/AOCnuZ4.png)

##### 6. Restart node and check that `anchors.dat` is removed
Restart your node, then navigate to your data directory. The image below is the data directory for a Bitcoin node while it is running. Notice that the `anchors.dat` file is missing. This is the expected behavior.
![anchor-gone](https://imgur.com/tydZLxa.png)
