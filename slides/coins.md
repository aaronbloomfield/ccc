Coin Logos in the slides
========================

[Go up to the slides page](../index.html) ([md](../index.md))


This page has the relevant code to include the coin logos in the reveal.js slides.  It's really just a reference for those creating the slides.  The licensing information for these logos can be found [here](images/logos/readme.html) ([md](images/logos/readme.md)).


### Subtitles

As a subtitle to the slide column header, such as [here](stablecoins.html#/casestudy):

```
<img src="../slides/images/logos/btc-coin-symbol.svg" class="cclogosubtitle">
<img src="../slides/images/logos/eth-coin-symbol.svg" class="cclogosubtitle">
```

### Slide style

To include an image on a slide, either as part of the text or as part of the h2 header, put the following before the first Markdown line of the slide content:

```
<!-- .slide: class="cclogo-slide" -->
```


### Coin logo

The text of the coin logo is the same.  To put it in a h2 header (be sure to include the slide style line, above):

```
## [![](../slides/images/logos/ppc-coin-symbol.svg){fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}](https://coinmarketcap.com/currencies/peercoin/) Peercoin
```

To put it as part of a list or paragraph:

```
## - [![](../slides/images/logos/ppc-coin-symbol.svg){fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}{fig-alt='ppc logo'}](https://coinmarketcap.com/currencies/peercoin/) Peercoin
```

### Viewing the coin logos

See [here](images/logos/readme.html) or [here](introduction.html#/allcoins).


### All the coin logos

They are sorted alphabetically by the coin abbreviation.

```
[![](../slides/images/logos/algo-coin-symbol.svg){fig-alt='algo logo'}](https://coinmarketcap.com/currencies/algorand/)
[![](../slides/images/logos/atom-coin-symbol.svg){fig-alt='atom logo'}](https://coinmarketcap.com/currencies/cosmos/)
[![](../slides/images/logos/aust-coin-symbol.svg){fig-alt='aust logo'}](https://coinmarketcap.com/currencies/anchorust/)
[![](../slides/images/logos/beam-coin-symbol.svg){fig-alt='beam logo'}](https://coinmarketcap.com/currencies/beam/)
[![](../slides/images/logos/btc-coin-symbol.svg){fig-alt='btc logo'}](https://coinmarketcap.com/currencies/bitcoin/)
[![](../slides/images/logos/btg-coin-symbol.svg){fig-alt='btg logo'}](https://coinmarketcap.com/currencies/bitcoin-gold/)
[![](../slides/images/logos/dai-coin-symbol.svg){fig-alt='dai logo'}](https://coinmarketcap.com/currencies/multi-collateral-dai/)
[![](../slides/images/logos/dot-coin-symbol.svg){fig-alt='dot logo'}](https://coinmarketcap.com/currencies/polkadot-new/)
[![](../slides/images/logos/erg-coin-symbol.svg){fig-alt='erg logo'}](https://coinmarketcap.com/currencies/ergo/)
[![](../slides/images/logos/etc-coin-symbol.svg){fig-alt='etc logo'}](https://coinmarketcap.com/currencies/ethereum-classic/)
[![](../slides/images/logos/eth-coin-symbol.svg){fig-alt='eth logo'}](https://coinmarketcap.com/currencies/ethereum/)
[![](../slides/images/logos/fei-coin-symbol.svg){fig-alt='fei logo'}](https://coinmarketcap.com/currencies/fei-usd/)
[![](../slides/images/logos/fil-coin-symbol.svg){fig-alt='fil logo'}](https://coinmarketcap.com/currencies/filecoin/)
[![](../slides/images/logos/firo-coin-symbol.svg){fig-alt='firo logo'}](https://coinmarketcap.com/currencies/firo/)
[![](../slides/images/logos/frax-coin-symbol.svg){fig-alt='frax logo'}](https://coinmarketcap.com/currencies/frax/)
[![](../slides/images/logos/juno-coin-symbol.svg){fig-alt='juno logo'}](https://coinmarketcap.com/currencies/juno/)
[![](../slides/images/logos/lunac-coin-symbol.svg){fig-alt='luna logo'}](https://coinmarketcap.com/currencies/terra-luna/)
[![](../slides/images/logos/matic-coin-symbol.svg){fig-alt='matic logo'}](https://coinmarketcap.com/currencies/polygon/)
[![](../slides/images/logos/mim-coin-symbol.svg){fig-alt='mim logo'}](https://coinmarketcap.com/currencies/magic-internet-money/)
[![](../slides/images/logos/mkr-coin-symbol.svg){fig-alt='mkr logo'}](https://coinmarketcap.com/currencies/maker/)
[![](../slides/images/logos/nmc-coin-symbol.svg){fig-alt='nmc logo'}](https://coinmarketcap.com/currencies/namecoin/)
[![](../slides/images/logos/neox-coin-symbol.svg){fig-alt='neox logo'}](https://coinmarketcap.com/currencies/neoxa/)
[![](../slides/images/logos/ppc-coin-symbol.svg){fig-alt='ppc logo'}](https://coinmarketcap.com/currencies/peercoin/)
[![](../slides/images/logos/rvn-coin-symbol.svg){fig-alt='rvn logo'}](https://coinmarketcap.com/currencies/ravencoin/)
[![](../slides/images/logos/sai-coin-symbol.svg){fig-alt='sai logo'}](https://coinmarketcap.com/currencies/single-collateral-dai/)
[![](../slides/images/logos/shib-coin-symbol.svg){fig-alt='shib logo'}](https://coinmarketcap.com/currencies/shiba-inu/)
[![](../slides/images/logos/sol-coin-symbol.svg){fig-alt='sol logo'}](https://coinmarketcap.com/currencies/solana/)
[![](../slides/images/logos/spell-coin-symbol.svg){fig-alt='spell logo'}](https://coinmarketcap.com/currencies/spell-token/)
[![](../slides/images/logos/storj-coin-symbol.svg){fig-alt='storj logo'}](https://coinmarketcap.com/currencies/storj/)
[![](../slides/images/logos/tomb-coin-symbol.svg){fig-alt='tomb logo'}](https://coinmarketcap.com/currencies/tomb/)
[![](../slides/images/logos/tribe-coin-symbol.svg){fig-alt='tribe logo'}](https://coinmarketcap.com/currencies/tribe/)
[![](../slides/images/logos/usdc-coin-symbol.svg){fig-alt='usdc logo'}](https://coinmarketcap.com/currencies/usd-coin/)
[![](../slides/images/logos/usdt-coin-symbol.svg){fig-alt='usdt logo'}](https://coinmarketcap.com/currencies/tether/)
[![](../slides/images/logos/ustc-coin-symbol.svg){fig-alt='ustc logo'}](https://coinmarketcap.com/currencies/terrausd/)
[![](../slides/images/logos/wbtc-coin-symbol.svg){fig-alt='wbtc logo'}](https://coinmarketcap.com/currencies/wrapped-bitcoin/)
[![](../slides/images/logos/weth-coin-symbol.svg){fig-alt='weth logo'}](https://coinmarketcap.com/currencies/weth/)
[![](../slides/images/logos/xlm-coin-symbol.svg){fig-alt='xlm logo'}](https://coinmarketcap.com/currencies/stellar/)
[![](../slides/images/logos/xpd-coin-symbol.svg){fig-alt='xpd logo'}](https://coinmarketcap.com/currencies/petrodollar/)
[![](../slides/images/logos/xpm-coin-symbol.svg){fig-alt='xpm logo'}](https://coinmarketcap.com/currencies/primecoin/)
[![](../slides/images/logos/zec-coin-symbol.svg){fig-alt='zec logo'}](https://coinmarketcap.com/currencies/zcash/)
```

### All the coin logos as images

<div class="cclogos">

[![](../slides/images/logos/algo-coin-symbol.svg){fig-alt='algo logo'}](https://coinmarketcap.com/currencies/algorand/)
[![](../slides/images/logos/atom-coin-symbol.svg){fig-alt='atom logo'}](https://coinmarketcap.com/currencies/cosmos/)
[![](../slides/images/logos/aust-coin-symbol.svg){fig-alt='aust logo'}](https://coinmarketcap.com/currencies/anchorust/)
[![](../slides/images/logos/beam-coin-symbol.svg){fig-alt='beam logo'}](https://coinmarketcap.com/currencies/beam/)
[![](../slides/images/logos/btc-coin-symbol.svg){fig-alt='btc logo'}](https://coinmarketcap.com/currencies/bitcoin/)
[![](../slides/images/logos/btg-coin-symbol.svg){fig-alt='btg logo'}](https://coinmarketcap.com/currencies/bitcoin-gold/)
[![](../slides/images/logos/dai-coin-symbol.svg){fig-alt='dai logo'}](https://coinmarketcap.com/currencies/multi-collateral-dai/)
[![](../slides/images/logos/dot-coin-symbol.svg){fig-alt='dot logo'}](https://coinmarketcap.com/currencies/polkadot-new/)
[![](../slides/images/logos/erg-coin-symbol.svg){fig-alt='erg logo'}](https://coinmarketcap.com/currencies/ergo/)
[![](../slides/images/logos/etc-coin-symbol.svg){fig-alt='etc logo'}](https://coinmarketcap.com/currencies/ethereum-classic/)
[![](../slides/images/logos/eth-coin-symbol.svg){fig-alt='eth logo'}](https://coinmarketcap.com/currencies/ethereum/)
[![](../slides/images/logos/fei-coin-symbol.svg){fig-alt='fei logo'}](https://coinmarketcap.com/currencies/fei-usd/)
[![](../slides/images/logos/fil-coin-symbol.svg){fig-alt='fil logo'}](https://coinmarketcap.com/currencies/filecoin/)
[![](../slides/images/logos/firo-coin-symbol.svg){fig-alt='firo logo'}](https://coinmarketcap.com/currencies/firo/)
[![](../slides/images/logos/frax-coin-symbol.svg){fig-alt='frax logo'}](https://coinmarketcap.com/currencies/frax/)
[![](../slides/images/logos/juno-coin-symbol.svg){fig-alt='juno logo'}](https://coinmarketcap.com/currencies/juno/)
[![](../slides/images/logos/lunac-coin-symbol.svg){fig-alt='luna logo'}](https://coinmarketcap.com/currencies/terra-luna/)
[![](../slides/images/logos/matic-coin-symbol.svg){fig-alt='matic logo'}](https://coinmarketcap.com/currencies/polygon/)
[![](../slides/images/logos/mim-coin-symbol.svg){fig-alt='mim logo'}](https://coinmarketcap.com/currencies/magic-internet-money/)
[![](../slides/images/logos/mkr-coin-symbol.svg){fig-alt='mkr logo'}](https://coinmarketcap.com/currencies/maker/)
[![](../slides/images/logos/nmc-coin-symbol.svg){fig-alt='nmc logo'}](https://coinmarketcap.com/currencies/namecoin/)
[![](../slides/images/logos/neox-coin-symbol.svg){fig-alt='neox logo'}](https://coinmarketcap.com/currencies/neoxa/)
[![](../slides/images/logos/ppc-coin-symbol.svg){fig-alt='ppc logo'}](https://coinmarketcap.com/currencies/peercoin/)
[![](../slides/images/logos/rvn-coin-symbol.svg){fig-alt='rvn logo'}](https://coinmarketcap.com/currencies/ravencoin/)
[![](../slides/images/logos/sai-coin-symbol.svg){fig-alt='sai logo'}](https://coinmarketcap.com/currencies/single-collateral-dai/)
[![](../slides/images/logos/shib-coin-symbol.svg){fig-alt='shib logo'}](https://coinmarketcap.com/currencies/shiba-inu/)
[![](../slides/images/logos/sol-coin-symbol.svg){fig-alt='sol logo'}](https://coinmarketcap.com/currencies/solana/)
[![](../slides/images/logos/spell-coin-symbol.svg){fig-alt='spell logo'}](https://coinmarketcap.com/currencies/spell-token/)
[![](../slides/images/logos/storj-coin-symbol.svg){fig-alt='storj logo'}](https://coinmarketcap.com/currencies/storj/)
[![](../slides/images/logos/tomb-coin-symbol.svg){fig-alt='tomb logo'}](https://coinmarketcap.com/currencies/tomb/)
[![](../slides/images/logos/tribe-coin-symbol.svg){fig-alt='tribe logo'}](https://coinmarketcap.com/currencies/tribe/)
[![](../slides/images/logos/usdc-coin-symbol.svg){fig-alt='usdc logo'}](https://coinmarketcap.com/currencies/usd-coin/)
[![](../slides/images/logos/usdt-coin-symbol.svg){fig-alt='usdt logo'}](https://coinmarketcap.com/currencies/tether/)
[![](../slides/images/logos/ustc-coin-symbol.svg){fig-alt='ustc logo'}](https://coinmarketcap.com/currencies/terrausd/)
[![](../slides/images/logos/wbtc-coin-symbol.svg){fig-alt='wbtc logo'}](https://coinmarketcap.com/currencies/wrapped-bitcoin/)
[![](../slides/images/logos/weth-coin-symbol.svg){fig-alt='weth logo'}](https://coinmarketcap.com/currencies/weth/)
[![](../slides/images/logos/xlm-coin-symbol.svg){fig-alt='xlm logo'}](https://coinmarketcap.com/currencies/stellar/)
[![](../slides/images/logos/xpd-coin-symbol.svg){fig-alt='xpd logo'}](https://coinmarketcap.com/currencies/petrodollar/)
[![](../slides/images/logos/xpm-coin-symbol.svg){fig-alt='xpm logo'}](https://coinmarketcap.com/currencies/primecoin/)
[![](../slides/images/logos/zec-coin-symbol.svg){fig-alt='zec logo'}](https://coinmarketcap.com/currencies/zcash/)

</div>
