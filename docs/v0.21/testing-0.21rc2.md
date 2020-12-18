# Testing Guide: Bitcoin Core 0.21 Release Candidate

This document outlines some of the upcoming Bitcoin Core 0.21 release changes and provides steps on how to test these changes.

## Why We Need You

The release candidate for version 0.21 was just tagged and is ready for testing. And, oh boy, is 0.21 the right time for you to get involved as a tester. It’s jam-packed with changes that need to be run on your operating system with your hardware. Database changes? Welcome [SQLite](https://github.com/bitcoin/bitcoin/pull/19077). A new network to test on? Hello, [Signet](https://github.com/bitcoin/bitcoin/pull/18267). Have you heard that Tor v2 is being deprecated? The upgrade to [Tor v3](http://github.com/bitcoin/bitcoin/pull/19954) is in 0.21. What about the wallet? [Total re-write](https://achow101.com/2020/10/0.21-wallets).

You can get involved by running through this guide and checking that everything works as it should on your machine. Please report back your findings [here](https://github.com/bitcoin/bitcoin/issues/20555). If everything went smoothly, let us know. If everything broke, definitely let us know!

## Preparation

#### 1. Grab Latest Release Candidate

**Current Release Candidate:** [Bitcoin Core 0.21rc3](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3) [(changelog)](https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft)

There are two ways to grab the latest release candidate: pre-compiled binary or source code.
The source code for the latest release can be grabbed from here: [latest release source code](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3).

If you want to use a binary, make sure to grab the correct one for your system. There are individual binaries for [Linux](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-x86_64-linux-gnu.tar.gz), [Arm (64 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-aarch64-linux-gnu.tar.gz), [Arm (32 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-arm-linux-gnueabihf.tar.gz), and [RISC-V](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc3/bitcoin-0.21.0rc3-riscv64-linux-gnu.tar.gz).

***NOTE FOR MACOSX USERS:***  
macOS users will need to either [compile from source](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc3) or use the [rc2 binary](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-osx.dmg) until [Apple's code signing issue](https://github.com/bitcoin/bitcoin/pull/20638) can be figured out.

#### 2. Compile Release Candidate

**If you grabbed a binary, skip this step.**

Before compiling, make sure that your system has all the right dependencies installed. As this guide utilizes the Bitcoin Core GUI, you must compile support for the GUI and have the `qt5` dependency already installed. To test the new wallet changes, make sure that you installed the `sqlite3` dependency. Here are some guides to compile Bitcoin Core from source for [UNIX/Linux](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md), [macOS](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md), [Windows](https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md), [FreeBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-freebsd.md), [NetBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-netbsd.md), and [OpenBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-openbsd.md).

#### 3. Create a new data directory
We will be creating and supplying a new data directory for our node to run from. Starting from the root of your Bitcoin release candidate directory, make yourself the new testing data directory with:

``` bash
mkdir /tmp/21-rc-test
```

This will ensure you aren't using any old data and that you can easily access it. We'll nuke it when this is all over.

---

## Testing Wallet Changes

The Bitcoin Core 0.21 release introduces sweeping changes to the wallet to move towards a well-designed wallet, capable of full-utilization of Bitcoin. This release introduces [descriptor wallets](https://diyhpl.us/wiki/transcripts/advancing-bitcoin/2020/2020-02-06-andrew-chow-descriptor-wallets/), a new type of wallet that generates addresses from [descriptors](https://bitcoinops.org/en/topics/output-script-descriptors/) instead of private keys. Tied together with this new wallet type is a new [SQLite](https://www.sqlite.org/index.html) database that aims to replace the aging [BerkeleyDB 4.8](https://blogs.oracle.com/berkeleydb/berkeley-db-48) database currently used.

**What's wrong with the current (legacy) wallets?**

The current wallet was designed when what Bitcoin could be used for was not yet fully understood. This led to a wallet design language that focused on maintaining a collection of [private keys](https://en.bitcoin.it/wiki/Private_key). As Bitcoin has progressed, this design language has held back the wallet from fully utilizing the expressiveness of [Bitcoin Script](https://en.bitcoin.it/wiki/Script). New features have had to be hacked on to the wallet.

**Why the Switch to SQLite?**

`BerkeleyDB 4.8` is 10 years old. This database is not actively maintained, not meant to be used as an application database, and is susceptible to file corruptions. Since the move to descriptor wallets introducing breaking compatibility changes, SQLite was chosen as a new database because it provides certain guarantees necessary for ensuring that the wallet remains backwards compatible moving forward. Furthermore, unlike `BerkeleyDB 4.8`, SQLite allows us to have one file wallet instead of a wallet directory. This helps with wallet portability.

### For more info on descritor wallets

AChow101 (the guy that wrote most of the code you are about to test) [wrote up some details about descriptor wallets](https://achow101.com/2020/10/0.21-wallets#descriptor-wallets) if you want to learn more.

### 1. Preparation

If you grabbed the binary for this release candidate, you're good to go. If you went down the source route, it is required that you installed the `sqlite3` dependency and compiled the source code with wallet functionality. Skip this section if you intentionally do not want wallet functionality or don't want to test it.

### Manual Testing

#### Using the GUI

**Skip to section below if you'd prefer to use the command line.**

##### Run node, provide data directory

We will now run `bitcoin-qt` and provide a data directory:

###### Source code

``` bash
./src/qt/bitcoin-qt -datadir=/tmp/21-rc-test
```

###### Binary Build

``` bash
./bin/bitcoin-qt -datadir=/tmp/21-rc-test
```

##### Create new Descriptor Wallet

###### New Default Behavior

Upon start, a node no longer creates a wallet by default. We will need to create a new wallet. If you are starting up a node for the first time or using a fresh data directory (as we are), you will be met with the following screen:

![new wallet intro](https://imgur.com/4UlP090.png)

###### Create New Wallet

Clicking on "Create a new Wallet" will bring you to the following screen. Give your wallet a name and make sure to have `Descriptor Wallet` enabled under `Advanced Options`. Hit `Create`. Congratulations, you've created your first descriptor wallet!

![descriptor](https://imgur.com/xIuT09U.png)

##### 4. Check for `wallet.dat`

First, shut down your node using File->Quit. Then, navigate to your wallet's data directory and ensure that a `wallets.dat` file has been created under a directory with the value you supplied as `Wallet Name`. In the case of this example, it is `my-descriptor-wallet`. You should see something like this:

![wallet-dat](https://imgur.com/w9mzT7q.png)

##### 5. (extra credit) Check that wallet is a descriptor wallet

Navigate to Window->Console. A console will pop up and in the text box enter `getwalletinfo`.

You should see something like:

```￼
{
  "walletname": "my-descriptor-wallet",
  "walletversion": 169900,
  "format": "sqlite",
  "balance": 0.00000000,
  "unconfirmed_balance": 0.00000000,
  "immature_balance": 0.00000000,
  "txcount": 0,
  "keypoolsize": 3000,
  "keypoolsize_hd_internal": 3000,
  "paytxfee": 0.00000000,
  "private_keys_enabled": true,
  "avoid_reuse": false,
  "scanning": false,
  "descriptors": true
}
```

See that last line?!? Descriptors true! :dancer:

### Using the command line

You'll need two terminal windows. (Make sure you don't have the GUI running as you can't use it as the same time as `bitcoind`.)

In the first window, you'll need to start your node:
```
./src/bitcoind -datadir=/tmp/21-rc-test
```

And in the other, you can create your wallet:

```
./src/bitcoin-cli -datadir=/tmp/21-rc-test -named createwallet wallet_name="my-descriptor-wallet" descriptors=true
```

While the logs fly by in that `bitcoind` window, once you've created a wallet you should see something like:

```
{
  "name": "my-descriptor-wallet",
  "warning": "Wallet is an experimental descriptor wallet"
}
```

Now let's check it's what we want. In that wallet window add:

```
./src/bitcoin-cli -datadir=/tmp/21-rc-test getwalletinfo
```

Which should result in something like:

```￼
{
  "walletname": "my-descriptor-wallet",
  "walletversion": 169900,
  "format": "sqlite",
  "balance": 0.00000000,
  "unconfirmed_balance": 0.00000000,
  "immature_balance": 0.00000000,
  "txcount": 0,
  "keypoolsize": 3000,
  "keypoolsize_hd_internal": 3000,
  "paytxfee": 0.00000000,
  "private_keys_enabled": true,
  "avoid_reuse": false,
  "scanning": false,
  "descriptors": true
}
```

If you see `"descriptors": true` in that last line, you are :money_with_wings:. Welcome to the future!

---

## Testing Torv3

Current nodes are limited to relaying addresses that fit into 128 bits. This limitation hinders Bitcoin nodes to a small set of network types. The upcoming Bitcoin Core release incorporates an implementation of [BIP 155](https://github.com/bitcoin/bips/blob/master/bip-0155.mediawiki), which introduces a new P2P message that allows network nodes to gossip addresses that are longer than 128 bits. This opens up the possibility of running nodes on new network types such as I2P and Tor V3.

**Why do we want to add compatibility for Tor v3 addresses?**

Tor v2 addresses contain various vulnerabilities that expose a node to a variety of [attacks](https://github.com/Attacks-on-Tor/Attacks-on-Tor). V2 addresses are also over a decade old, and they are scheduled to be [retired](https://blog.torproject.org/v2-deprecation-timeline) by October 15, 2021. [Tor Onion v3](https://www.jamieweb.net/blog/onionv3-hidden-service/) addresses use a stronger encryption format that fixes some of v2's weaknesses.

**What else do I need to know about this change?**

Accommodating for the new address sizes makes the `peers.dat` backwards incompatible. A `peers.dat` file created with a 0.21 node will not be backwards compatible with a node <0.21.

### Preparation

Tor must be installed on your system for the Tor related tests to function properly. The script currently assumes that Tor is running on the default UNIX port of 9050. Below are some guides to setting up the `tor` package on your system.

#### macOSX Instructions with Homebrew

The easiest way to install `tor` for MacOSX is to use [homebrew](https://brew.sh/). This package manager allows you to easily install packages right from the command line easily.

To install homebrew (if not already installed):
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Assuming that goes well, run:

```bash
brew install tor
```

And then, to get Tor running:

```bash
tor
```

#### TODO: tor install instructions for linux/windows

For those wanting to dig deeper, [Bitcoin Core provides documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md) on how to test running a node on Tor. There is little manual config to be done. In fact, on some Linux distros, if there is a Tor daemon running on the machine, `bitcoind` will pick it up and authenticate with a cookie file.

#### Listen on TorV3

We are going to setup our node to [listen on Tor automatically](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#3-automatically-listen-on-tor). This means that the node is going to look for other peers on the Tor network.

The `bitcoin.conf` file is used to [configure](https://en.bitcoin.it/wiki/Running_Bitcoin#Bitcoin.conf_Configuration_File) how your node will run. This file is not automatically created and must be created manually. This file will be created in the data directory that we previously created while testing the wallet. From your data directory, run:

``` bash
touch /tmp/21-rc-test/bitcoin.conf
```

We will be adding settings to the bitcoin.conf that will allow us to connect and find peers through the Tor network. Since the Bitcoin Core 0.21 release has not actually been released yet, `Torv3` nodes are rare to come across. Because of this, we are going to manually add a `Torv3` node that has been tracked down. Using your favorite text editor, add the following to the newly created `bitcoin.conf` file:

```bash
proxy=127.0.0.1:9050 #If you use Windows, this could possibly be 127.0.0.1:9150 in some cases.
listen=1
bind=127.0.0.1
onlynet=onion

addnode=sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd.onion:8333
addnode=rp7k2go3s5lyj3fnj6zn62ktarlrsft2ohlsxkyd7v3e3idqyptvread.onion:8333
addnode=d6jwdcoo2l3gbjps6asgg4nhp2gn5oao3wj333o43ssqnjaliehytfad.onion:8333
```

(Cutting and pasting the text above should do the trick, but you can see the [example bitcoin.conf](https://github.com/bitcoin/bitcoin/blob/master/share/examples/bitcoin.conf) file for an overview of the available options.

### Manual Testing

Ready to test? There are two ways to try this.

##### 3a. Start bitcoind

```bash
./src/bitcoind -datadir=/tmp/21-rc-test
```

You will see a flurry of messages as the logs pass by. Open a new terminal window and let's query our running node to see who we've connected to:

```bash
./src/bitcoin-cli -datadir=/tmp/21-rc-test getpeerinfo
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

If you have `rp7k2go3s5lyj3fnj6zn62ktarlrsft2ohlsxkyd7v3e3idqyptvread`, `sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd`, or `d6jwdcoo2l3gbjps6asgg4nhp2gn5oao3wj333o43ssqnjaliehytfad` in the response, you've successfully connected to a Tor v3 node! :tada:

##### 3b. Launch bitcoin-qt

Launch `bitcoin-qt` and provide the data directory we have been using:

###### Source code

``` bash
./src/qt/bitcoin-qt -datadir=/tmp/21-rc-test
```

###### Binary Build

``` bash
./bin/bitcoin-qt -datadir=/tmp/21-rc-test
```

###### Check for Tor peers

Navigate to and click on `Window->Peers` to bring up information on the connected Peers.
![Window->Peers](https://imgur.com/gONbuA7.png)

###### Visually Examine Peer Information

You can differentiate a Torv3 node from a Torv2 node by looking at how long it is. A Torv3 node is 56 characters long and always ends in a `d` such as: `sxjbhmhob2xasx3vdsy5ke5j5jwecmh3ca4wbs7wf6sg4g2lm3mbszqd.onion`. A Torv2 node is 16 characters long, such as: `uovsp2yltnaojq6l.onion:8333`. Your Peer window should look something like this:

![torv3-peers](https://imgur.com/ISzPLKe.png)

#### Clean up data directory

We want to delete the `bitcoin.conf` in our data directory as we no longer need these configurations.

``` bash
rm /tmp/21-rc-test/bitcoin.conf
```

---

## Testing Signet

The Bitcoin [testnet](https://en.bitcoin.it/wiki/Testnet) is a proof-of-work based testing framework where volunteers are relied on to mine blocks with real CPU power and in turn receive worthless `testnet` coins. Since the economics of the `mainnet` are not at play here, we get a network that is unpredictable and, frustratingly, unreliable.

This release introduces [Signet](https://bitcoinops.org/en/topics/signet/), a new testing network. Signet does away with decentralized proof-of-work in favor of a centralized consensus mechanism where a group with authority is in charge of creating new blocks based on valid signatures. The aim is to create a testing network that is predictable and reliable.

### Manual Testing

The [Bitcoin Wiki](https://en.bitcoin.it/wiki/Signet) contains excellent documentation on connecting to and testing Signet. Building a custom signet is pretty involved but jumping on the default global signet should be just as fun. Give it a whirl!

---

## Testing Anchors

An [eclipse attack](https://cs-people.bu.edu/heilman/eclipse/) is an attack on bitcoin's p2p network. In order for the attack to be effective, the attacker aims to restart your node and then supply your node with IP addresses controlled by the attacker. Eclipse attacks reduce the soundness of second layer solutions such as the lightning network.

When you're node connects to the Bitcoin network, it makes [two outbound block-relay-only connections](https://github.com/bitcoin/bitcoin/pull/15759). This release introduces [Anchor Connections](https://github.com/bitcoin/bitcoin/pull/17428). Anchors are the two outbound block-relay connections your node is connected to; logged to an `anchors.dat` file so that they can be used upon a node restart. Under the assumption that you were connected to honest nodes before the attack, this aims to reduce the chances of an eclipse attack from being successful.

### Manual Testing

When a node shuts down cleanly, then an `anchors.dat` file should appear in the node's data directory. We want to check that this file is created upon node shut-down, and deleted on node start-up.

#### Start up your node through bitcoin-qt

Start your node however you do so. If the release candidate is integrated into your desktop environment or is packaged into a `.dmg` in the case of macOS, launch `bitcoin-qt` from your application launcher. Otherwise, starting from the root directory of your binary or source download, run:

``` bash
./src/qt/bitcoin-qt
```

#### Navigate to Peers Window

Navigate to and click on `Window->Peers` to bring up information on the connected Peers.
![Window->Peers](https://imgur.com/gONbuA7.png)

#### Confirm Peer connections

At the peer information page, visually check that you are connected to peers.
![peers](https://imgur.com/7M6AW6D.png)

#### Shut down your node

Shut down your node by navigating and clicking on File->Exit.
![shut-down](https://imgur.com/GSgvHhc.png)

#### Check for an `anchors.dat` file

Navigate to the data directory for your node.
![check-anchorsdat](https://imgur.com/AOCnuZ4.png)

#### Restart node and check that `anchors.dat` is removed

Restart your node, then navigate to your data directory. The image below is the data directory for a Bitcoin node while it is running. Notice that the `anchors.dat` file is missing. This is the expected behavior.
![anchor-gone](https://imgur.com/tydZLxa.png)

## Freestyle

You've reached the end of the regularly scheduled programming. Take a little time to explore some of your recent use-case and/or revisit your favorite feature of QT or `bitcoind` (if any). Just poke around and make sure everything works as expected.

## Clean-up

Use this command to remove all the data you played around with:

```bash
rm -rf /tmp/21-rc-test/
```

## The Most Important Step

Thank you for your help in making Bitcoin as robust as it can be. Please remember to add a comment on [v0.21.0 testing issue detailing](https://github.com/bitcoin/bitcoin/issues/20555):

1. Your hardware and operating system
1. Which release candidate you tested and whether you compiled from source or used a binary (e.g. 0.21rc2 binary or 0.21rc3 compiled from source)
1. What you tested (e.g., created a descriptor wallet, connected over Torv3, ran through the anchors test, your favorite features)
1. Any other relevant findings

**Don't be shy about leaving a comment even if everything worked great!** We want to hear from you and so it doesn't count unless you leave some feedback. Plus, you'll be Bitcoin GitHub famous!

Thanks for your contribution and for taking the time to make Bitcoin awesome.
