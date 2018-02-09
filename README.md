![Inspem](logo.jpg "Inspem")

# Inspem smart contract

* _Standart_        : ERC20
* _Name_            : Inspem
* _Ticket_          : INP
* _Decimals_        : 18
* _Emission_        : Mintable
* _Crowdsales_      : 2
* _Fiat dependency_ : No
* _Tokens locked_   : Yes

## Smart-contracts description

Contract mint bounty and founders tokens after main sale stage finished. 
Crowdsale contracts have special function to retrieve transferred in errors tokens.
Also crowdsale contracts have special function to direct mint tokens in wei value (featue implemneted to support external pay gateway).

### Contracts contains
1. _InspemToken_ - Token contract
2. _Presale_ - Presale contract
3. _Mainsale_ - ICO contract
4. _Configurator_ - contract with main configuration for production

### How to manage contract
To start working with contract you should follow next steps:
1. Compile it in Remix with enamble optimization flag and compiler 0.4.18
2. Deploy bytecode with MyEtherWallet. Gas 5100000 (actually 5073514).
3. Call 'deploy' function on addres from (3). Gas 4000000 (actually 3979551). 

Contract manager must call finishMinting after each crowdsale milestone!
To support external mint service manager should specify address by calling _setDirectMintAgent_. After that specified address can direct mint INP tokens by calling _directMint_.

### How to invest
To purchase tokens investor should send ETH (more than minimum 0.1 ETH) to corresponding crowdsale contract.
Recommended GAS: 250000, GAS PRICE - 21 Gwei.

### Wallets with ERC20 support
1. MyEtherWallet - https://www.myetherwallet.com/
2. Parity 
3. Mist/Ethereum wallet

EXODUS not support ERC20, but have way to export key into MyEtherWallet - http://support.exodus.io/article/128-how-do-i-receive-unsupported-erc20-tokens

Investor must not use other wallets, coinmarkets or stocks. Can lose money.

## Main network configuration

* _Minimal insvested limit_     : 0.1 ETH
* _Price_                       : 1 ETH = 5 000 INP
* _Bounty tokens percent_       : 5% 
* _Founders tokens percent_     : 15% 
* _For sale tokens percent_     : 80% 
* _Founders tokens wallet_      : 0xAFA1bFDF3112d4d3e9CaC4A100a0eBf22231878c
* _Bounty tokens wallet_        : 0x3c0260Ce19363350264D23Fd1A48F50001dBb5ee
* _Contract owner_              : 

### Links
1. _Token_ -
2. _Presale_ -
3. _Mainsale_ -

### Referal system
* _Referer percent_ - 5%
* _Limitations_ - Investor сan't accrue bonus to himself

### Crowdsale stages

#### Presale
* _Hardcap_                    : 2 000 ETH
* _Start_                      : 29 March 2018 13:00:00 GMT
* _Wallet_                     : 0x16Af606E2f396DDdde61809A2C73b8E64A81c1Ea

_Milestones_
1. 14 days                     : bonus +100% 
2. 14 days                     : bonus +50% 

#### ICO
* _Hardcap_                    : 30 000 ETH
* _Start_                      : 
* _Wallet_                     : 0xb24EDbc6d7EDa33af4A91d57c621e5eB86c02BcF

_Milestones_
1. 7 days                      : bonus +30% 
2. 7 days                      : bonus +20% 
3. 7 days                      : bonus +10% 
4. 7 days                      : without bonus

## Ropsten network configuration 

### links
1. _Token_ - https://ropsten.etherscan.io/address/0xe2ab58c360311aa2a5269ebc3b95661cd24c6191
2. _Presale_ - https://ropsten.etherscan.io/address/0xce29f88c878582df7369cd39a7e8f1afaa17faee
3. _Mainsale_ - https://ropsten.etherscan.io/address/0xa5a6edd335e322cc6fd68bac8053559f339283bd


### Crowdsale stages

#### Presale

* _Price_                    : 5 000 INP per 1 ETH
* _Minimal investment limit_ : 0.1 ETH
* _Hardcap_                  : 4 ETH
* _Wallet_                   : 0x8fd94be56237ea9d854b23b78615775121dd1e82

_Milestones_

* 14 days - bonus 100%
* 14 days - bonus 50%


##### Purchasers

* 0.1 ETH => 500 tokens + 500 bonus tokens (100%), gas = 116968
https://ropsten.etherscan.io/tx/0x7a2d44c5d6d7e7f30a7d4ba87f667fa7214c36b55a6f88d585e5c87aec53d581

* 4 ETH => 20000 tokens + 20000 bonus tokens (100%), 2000 referer tokens (5%), gas = 125189
https://ropsten.etherscan.io/tx/0x574dad6b3489df1f2fc517f493114e23a9d417139ad760dd69ea31032994c82d

* 0.1 ETH => rejected txn, hardcap is reached allready, gas = 30276
https://ropsten.etherscan.io/tx/0xbe152937d5b75cbc91ee901ba4ae37154a4685ebf883aa1b784e47cca3756f04


##### Service operations

* setStart, gas = 27868
https://ropsten.etherscan.io/tx/0xee8fdae04f4c34906d185572d48d1bd1c1e223293166a8e82cfe8ef8ed00c11b

* setHardcap, gas = 27972
https://ropsten.etherscan.io/tx/0x9cf996e39a2483ff0a2e2994b5c2bb78f35335770161a8310b6b8bad0935629c

* finish, gas = 30439
https://ropsten.etherscan.io/tx/0xca6b11db3183ce658df615a9ea2f4b48d761fdc3b5af254e45b9a1471b7aed38

#### Mainsale
* _Price_                     : 5 000 INP per 1 ETH
* _Minimal investment limit_  : 0.1 ETH
* _Hardcap_                   : 30 000 ETH
* _Wallet_                    : 0x8fd94be56237ea9d854b23b78615775121dd1e82
* _Founders tokens percent_   : 10%
* _Bounty tokens percent_     : 5%
* _Founders tokens wallet_    : 0x95ea6a4ec9f80436854702e5f05d238f27166a05
* _Bounty tokens wallet_      : 0x95ea6a4ec9f80436854702e5f05d238f27166a04

_Milestones_

* 7 days - bonus 30%
* 7 days - bonus 20%
* 7 days - bonus 10%
* 7 days - without bonus

##### Purchasers

* 0.3 ETH => 1500 tokens without bonus, gas = 90638
https://ropsten.etherscan.io/tx/0x12c7ac325432e59620215df60e4fccae4ab2685f13ac289dc8f41c6fc5b9a60b

* 2 ETH => 10000 tokens without bonus, 500 referer tokens (5%), gas = 128859
https://ropsten.etherscan.io/tx/0xe07dfcc59091cf7815a6d9b413ed735ecf8f362b9c68faffc24a52134267cd95

* 1 ETH => rejected txn, investor сan't accrue bonus to himself, gas = 95945
https://ropsten.etherscan.io/tx/0xa506904d36d5be3f7d7a44946e17815a34f3d8ab29e0f17d03d6b62d6112ebbd

* 1 ETH => rejected txn, sale is over, gas = 22058
https://ropsten.etherscan.io/tx/0x37fdd36dab70e245b874f4cd936601aaea21fce6bbf80bb9e502d49eff4215ee

##### Service operations

* setStart, gas = 27978
https://ropsten.etherscan.io/tx/0xa245d4af7fe1b67433614ef4d28f5f0d257703d0f373c219ebc89027d1175d3a

* finish, gas = 131185
https://ropsten.etherscan.io/tx/0xc33fd32e77c7542c54acf3f51cccaf3fa493d9524f02f1e4d4d8dea354960a6d

##### Token holders
https://ropsten.etherscan.io/token/0xe2ab58c360311aa2a5269ebc3b95661cd24c6191#balances
