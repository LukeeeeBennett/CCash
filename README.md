# CCash

A webserver hosting a bank system for Minecraft, able to be used from web browser or from CC/OC if you're playing modded.

the currency model most Minecraft Servers adopt if any, is resource based, usually diamonds, this model is fraught with issues however:

- the primary issue is minecraft worlds are infinite leading to hyper inflation as everyone accrues more diamonds
- there is no central authority minting the currency, any consumer can introduce more diamonds to the system
- some resources are passively reapable, making the generation of currency a larger focus then of products
- locality is required for transaction
- theft is possible, ownership is possession based

CCash solves these issues and adds a level of abstraction, the main philosophy of CCash is to have fast core operations that other services build on

## Build

drogon depedencies (varies by OS/distro)
```
# Debian
sudo apt install libjsoncpp-dev uuid-dev openssl libssl-dev zlib1g-dev

# macOS
brew install jsoncpp ossp-uuid openssl zlib
```

building the project

```
git clone --recurse-submodule https://github.com/EntireTwix/CCash/
cd CCash
mkdir build
cd build
cmake ..
make -j<threads>
```

then edit config.json to include the paths to your certs for HTTPS (I use certbot), or just remove the listener for port 443.

```
vim ../config.json
```

finally, run the program

```
sudo ./bank <admin password> <saving frequency in minutes> <threads>
```

## Connected Services

Using the Bank's API allows (you/others) to (make/use) connected services that utilize the bank, a couple ideas can be found [here](services.md)

## Developing for
as a dev check out 
* [APIs](https://github.com/EntireTwix/CCash/blob/main/APIs.md)
* [endpoints](https://github.com/EntireTwix/CCash/blob/main/help.md)

## FAQ
**Q:** how is money initially injected into the economy

**A:** you can take any approach you want, one that I recommend is using a one way exchange via the CC ATM above to have players mine the initial currency, this rewards early adopters and has a sunk cost effect in that the resource is promptly burned

## [Contributions](https://github.com/EntireTwix/CCash/graphs/contributors)
Thank you to the contributors

| Name                                        | Project Work                                                            | Connected Service Work |
| :------------------------------------------ | ----------------------------------------------------------------------- | ---------------------- |
| [Expand](https://github.com/Expand-sys)     | Slight docker changes                                                   | Frontend               |
| [React](https://github.com/Reactified)      | CC API, Logo                                                            | CC Shop, CC ATM.       |
| [Doggo](https://github.com/FearlessDoggo21) | Logs loading/adding Optimized, HTTP convention suggestions, Python API  | `N/A`                  |
| [Luke](https://github.com/LukeeeeBennett)   | JS API, Docker, Slight Doc edits                                        | `N/A`                  |
| [Jolly](https://github.com/STBoyden)        | Slight Doc edits                                                        | `N/A`                  |

## Features

### Performance
- In memory database instead of on disk
- **NOT** written in Lua, like a OC/CC implementation
- written in **C++**, arguably the fastest language
- **multi-threaded**
- **parallel hashmaps** a far [superior](https://greg7mdp.github.io/parallel-hashmap/) HashMap implementation to the STD, that also benefits from multi-threaded
- **Drogon** is a very fast [web framework](https://www.techempower.com/benchmarks/#section=data-r20&hw=ph&test=composite)
- **xxHash** for the hashing of passwords, it is very fast: [graph](https://user-images.githubusercontent.com/750081/61976089-aedeab00-af9f-11e9-9239-e5375d6c080f.png)
- **Lightweight**, anecodotally I experienced (on my laptop's i7 6700K, 8 threads):
  - memory usage of 8.5 MB (with 0 users)
  - 0.0% CPU usage idle 
  - <1% CPU on average 
  - 1000 requests in parallel completed in 0.85s which spiked CPU usage to 7%
  
### Safety

- **Tamper Proof** relative to an in-game implementation
- **Auto-Saving** and Saves on close
- All passwords are **Hashed**
- **HTTPS** (OpenSSL)

### Accessibility

- **RESTful** API for connected services like a market, gambling, or anything else you can think of
- able to be used millions of blocks away, across dimensions, servers, **vanilla or modded**.
- **Logging** of all transactions, configurable in [consts.hpp](include/consts.hpp)

### Other
- **return balance on deletion**, configurable in [consts.hpp](include/consts.hpp)

## Dependencies

- [Parallel HashMap](https://github.com/greg7mdp/parallel-hashmap/tree/master)
- [Drogon](https://github.com/an-tao/drogon/tree/master)
- [XXHASH](https://github.com/Cyan4973/xxHash)
