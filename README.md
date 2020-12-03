<div align="center">
  <h1>Bitcoin Core Release Candidate Testing</h1>
  <p> Current Release Candidate: <a href="https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc2">Bitcoin Core 0.21rc2</a> <a href="https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft">(changelog)</a></p>
  <p> Changes tested:
    <a href="tests/tor/README.md">Tor</a>,
    <a href="">Signet</a>,
    <a href="">Anchors</a>,
    <a href="">Wallet Changes</a>,
    <a href="">Wtxid</a>,
    <a href="">Tx Fetching Logic</a>
</div>


It’s up to all of us to make sure that Bitcoin is the best it can be. It takes a lot of work to ensure that every release safely bridges us to the future. We need your eyes (and your computer) to make sure that the upcoming Bitcoin Core Release Candidate is as good as it can be. Come lend a hand!

## Running Automated Test Suite
The script will fetch a copy of the current Bitcoin Core Release Candidate, verify the files integrity against [cryptographic checksums](), and run tests that will help ensure the soundness of the release candidate. At runtime, a configuration menu allows you to customize how the script will run.

#### 1. Clone script repository
```
$ git clone https://github.com/jarolrod/bitcoin-core-rc-testing.git
$ cd bitcoin-core-rc-testing
```
#### 2. Give script execution permission
```
$ chmod +x ./bitcoin-core-rc-testing.sh
```
#### 3. Execute script
```
$ ./bitcoin-core-rc-testing.sh
```

## Running Manual Tests
<p align="center"><strong>NOTE: Not currently supported</strong></p>

For those who want to get more involved with the testing, you can run the script in manual mode. This allows you to supply an already downloaded release candidate and run tests manually.
Grab a copy of the release current release candidate from [github](https://github.com/bitcoin/bitcoin/releases/tag/v0.21.0rc2) or [bitcoincore.org](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/). You can choose to download the source code or binaries.

#### Manual Testing with Binaries
There are individual binaries for [MacOS](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-osx.dmg), [Linux](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-x86_64-linux-gnu.tar.gz), [Arm (64 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-aarch64-linux-gnu.tar.gz), [Arm (32 bit)](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-arm-linux-gnueabihf.tar.gz), and [RISC-V](https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2-riscv64-linux-gnu.tar.gz). Make sure to grab the correct binary for your specific machine.

After cloning the repo, downloading the appropriate binary, and giving the script execution permission: supply the release candidate binary directory to the script.
```
$ ./bitcoin-core-rc-testing.sh --binary={binary-directory}
```

#### Manual Testing with Source Code
Compiling Bitcoin Core is an involved process. It will also take some time, depending on your hardware. For beginners, it is advised to stick with the binary releases.

Before compiling, make sure that your system has all the right dependencies installed. Here are some guides to compile Bitcoin Core from source for [OSX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md), [windows](https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md), [FreeBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-freebsd.md), [NetBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-netbsd.md), [OpenBSD](https://github.com/bitcoin/bitcoin/blob/master/doc/build-openbsd.md), and [UNIX](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md).

Sample compile process:
```
$ curl https://bitcoincore.org/bin/bitcoin-core-0.21.0/test.rc2/bitcoin-0.21.0rc2.tar.gz -O
$ tar -xf bitcoin-0.21.0rc2.tar.gz
$ cd bitcoin-0.21.0rc2
$ ./autogen.sh
$ ./configure
$ make -j{n}
```

After compiling, supply script the source code directory:
```
$ ./bitcoin-core-rc-testing.sh --source={source-directory}
```
For those upgrading from a previous release, [a draft of the 0.21 release notes](https://github.com/bitcoin-core/bitcoin-devwiki/wiki/0.21.0-Release-Notes-Draft#how-to-upgrade) have instructions.
