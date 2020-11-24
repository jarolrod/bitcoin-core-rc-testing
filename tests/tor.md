# Testing Tor

[Bitcoin Core provides documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md) on how to test running a node on Tor. There is little manual config to be done. In fact, on some linux distros if there is a tor daemon running on the machine bitcoind will pick it up and authenticate with a cookie file.

There are two setups that would equally valuable to test.
  - [Running a Bitcoin Core hidden server](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#2-run-a-bitcoin-core-hidden-server)
  - [Automatically listening on Tor](https://github.com/bitcoin/bitcoin/blob/master/doc/tor.md#3-automatically-listen-on-tor)
