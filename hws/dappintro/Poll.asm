
======= IPoll.sol:IPoll =======
EVM assembly:


======= Poll.sol:Poll =======
EVM assembly:
    /* "Poll.sol":270:4220  contract Poll is IPoll {... */
  mstore(0x40, 0x80)
    /* "Poll.sol":2499:2649  constructor() {... */
  callvalue
  dup1
  iszero
  tag_1
  jumpi
  0x00
  dup1
  revert
tag_1:
  pop
    /* "Poll.sol":2517:2533  addChoice("red") */
  tag_4
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x03
  dup2
  mstore
  0x20
  add
  0x7265640000000000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2517:2526  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2517:2533  addChoice("red") */
  0x20
  shr
  jump	// in
tag_4:
    /* "Poll.sol":2537:2556  addChoice("orange") */
  tag_6
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x06
  dup2
  mstore
  0x20
  add
  0x6f72616e67650000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2537:2546  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2537:2556  addChoice("orange") */
  0x20
  shr
  jump	// in
tag_6:
    /* "Poll.sol":2560:2579  addChoice("yellow") */
  tag_7
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x06
  dup2
  mstore
  0x20
  add
  0x79656c6c6f770000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2560:2569  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2560:2579  addChoice("yellow") */
  0x20
  shr
  jump	// in
tag_7:
    /* "Poll.sol":2583:2601  addChoice("green") */
  tag_8
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x05
  dup2
  mstore
  0x20
  add
  0x677265656e000000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2583:2592  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2583:2601  addChoice("green") */
  0x20
  shr
  jump	// in
tag_8:
    /* "Poll.sol":2605:2622  addChoice("blue") */
  tag_9
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x04
  dup2
  mstore
  0x20
  add
  0x626c756500000000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2605:2614  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2605:2622  addChoice("blue") */
  0x20
  shr
  jump	// in
tag_9:
    /* "Poll.sol":2626:2645  addChoice("purple") */
  tag_10
  mload(0x40)
  dup1
  0x40
  add
  0x40
  mstore
  dup1
  0x06
  dup2
  mstore
  0x20
  add
  0x707572706c650000000000000000000000000000000000000000000000000000
  dup2
  mstore
  pop
    /* "Poll.sol":2626:2635  addChoice */
  shl(0x20, tag_5)
    /* "Poll.sol":2626:2645  addChoice("purple") */
  0x20
  shr
  jump	// in
tag_10:
    /* "Poll.sol":270:4220  contract Poll is IPoll {... */
  jump(tag_11)
    /* "Poll.sol":2814:2987  function addChoice (string memory _name) public override {... */
tag_5:
    /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
  mload(0x40)
  dup1
  0x60
  add
  0x40
  mstore
  dup1
    /* "Poll.sol":2906:2917  num_choices */
  sload(0x02)
    /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
  dup2
  mstore
  0x20
  add
    /* "Poll.sol":2919:2924  _name */
  dup3
    /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
  dup2
  mstore
  0x20
  add
    /* "Poll.sol":2926:2927  0 */
  0x00
    /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
  dup2
  mstore
  pop
    /* "Poll.sol":2875:2883  _choices */
  0x01
    /* "Poll.sol":2875:2896  _choices[num_choices] */
  0x00
    /* "Poll.sol":2884:2895  num_choices */
  sload(0x02)
    /* "Poll.sol":2875:2896  _choices[num_choices] */
  dup2
  mstore
  0x20
  add
  swap1
  dup2
  mstore
  0x20
  add
  0x00
  keccak256
    /* "Poll.sol":2875:2928  _choices[num_choices] = Choice(num_choices, _name, 0) */
  0x00
  dup3
  add
  mload
  dup2
  0x00
  add
  sstore
  0x20
  dup3
  add
  mload
  dup2
  0x01
  add
  swap1
  dup2
  tag_13
  swap2
  swap1
  tag_14
  jump	// in
tag_13:
  pop
  0x40
  dup3
  add
  mload
  dup2
  0x02
  add
  sstore
  swap1
  pop
  pop
    /* "Poll.sol":2954:2965  num_choices */
  sload(0x02)
    /* "Poll.sol":2937:2966  choiceAddedEvent(num_choices) */
  0x8c289382d6fd42a02a06e885da5a69cb0f21294bbfc7acc91d5cf3ced61ca0c4
  mload(0x40)
  mload(0x40)
  dup1
  swap2
  sub
  swap1
  log2
    /* "Poll.sol":2970:2981  num_choices */
  0x02
  0x00
    /* "Poll.sol":2970:2983  num_choices++ */
  dup2
  sload
  dup1
  swap3
  swap2
  swap1
  tag_15
  swap1
  tag_16
  jump	// in
tag_15:
  swap2
  swap1
  pop
  sstore
  pop
    /* "Poll.sol":2814:2987  function addChoice (string memory _name) public override {... */
  pop
  jump	// out
    /* "#utility.yul":7:106   */
tag_17:
    /* "#utility.yul":59:65   */
  0x00
    /* "#utility.yul":93:98   */
  dup2
    /* "#utility.yul":87:99   */
  mload
    /* "#utility.yul":77:99   */
  swap1
  pop
    /* "#utility.yul":7:106   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":112:292   */
tag_18:
    /* "#utility.yul":160:237   */
  0x4e487b7100000000000000000000000000000000000000000000000000000000
    /* "#utility.yul":157:158   */
  0x00
    /* "#utility.yul":150:238   */
  mstore
    /* "#utility.yul":257:261   */
  0x41
    /* "#utility.yul":254:255   */
  0x04
    /* "#utility.yul":247:262   */
  mstore
    /* "#utility.yul":281:285   */
  0x24
    /* "#utility.yul":278:279   */
  0x00
    /* "#utility.yul":271:286   */
  revert
    /* "#utility.yul":298:478   */
tag_19:
    /* "#utility.yul":346:423   */
  0x4e487b7100000000000000000000000000000000000000000000000000000000
    /* "#utility.yul":343:344   */
  0x00
    /* "#utility.yul":336:424   */
  mstore
    /* "#utility.yul":443:447   */
  0x22
    /* "#utility.yul":440:441   */
  0x04
    /* "#utility.yul":433:448   */
  mstore
    /* "#utility.yul":467:471   */
  0x24
    /* "#utility.yul":464:465   */
  0x00
    /* "#utility.yul":457:472   */
  revert
    /* "#utility.yul":484:804   */
tag_20:
    /* "#utility.yul":528:534   */
  0x00
    /* "#utility.yul":565:566   */
  0x02
    /* "#utility.yul":559:563   */
  dup3
    /* "#utility.yul":555:567   */
  div
    /* "#utility.yul":545:567   */
  swap1
  pop
    /* "#utility.yul":612:613   */
  0x01
    /* "#utility.yul":606:610   */
  dup3
    /* "#utility.yul":602:614   */
  and
    /* "#utility.yul":633:651   */
  dup1
    /* "#utility.yul":623:704   */
  tag_43
  jumpi
    /* "#utility.yul":689:693   */
  0x7f
    /* "#utility.yul":681:687   */
  dup3
    /* "#utility.yul":677:694   */
  and
    /* "#utility.yul":667:694   */
  swap2
  pop
    /* "#utility.yul":623:704   */
tag_43:
    /* "#utility.yul":751:753   */
  0x20
    /* "#utility.yul":743:749   */
  dup3
    /* "#utility.yul":740:754   */
  lt
    /* "#utility.yul":720:738   */
  dup2
    /* "#utility.yul":717:755   */
  sub
    /* "#utility.yul":714:798   */
  tag_44
  jumpi
    /* "#utility.yul":770:788   */
  tag_45
  tag_19
  jump	// in
tag_45:
    /* "#utility.yul":714:798   */
tag_44:
    /* "#utility.yul":535:804   */
  pop
    /* "#utility.yul":484:804   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":810:951   */
tag_21:
    /* "#utility.yul":859:863   */
  0x00
    /* "#utility.yul":882:885   */
  dup2
    /* "#utility.yul":874:885   */
  swap1
  pop
    /* "#utility.yul":905:908   */
  dup2
    /* "#utility.yul":902:903   */
  0x00
    /* "#utility.yul":895:909   */
  mstore
    /* "#utility.yul":939:943   */
  0x20
    /* "#utility.yul":936:937   */
  0x00
    /* "#utility.yul":926:944   */
  keccak256
    /* "#utility.yul":918:944   */
  swap1
  pop
    /* "#utility.yul":810:951   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":957:1050   */
tag_22:
    /* "#utility.yul":994:1000   */
  0x00
    /* "#utility.yul":1041:1043   */
  0x20
    /* "#utility.yul":1036:1038   */
  0x1f
    /* "#utility.yul":1029:1034   */
  dup4
    /* "#utility.yul":1025:1039   */
  add
    /* "#utility.yul":1021:1044   */
  div
    /* "#utility.yul":1011:1044   */
  swap1
  pop
    /* "#utility.yul":957:1050   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":1056:1163   */
tag_23:
    /* "#utility.yul":1100:1108   */
  0x00
    /* "#utility.yul":1150:1155   */
  dup3
    /* "#utility.yul":1144:1148   */
  dup3
    /* "#utility.yul":1140:1156   */
  shl
    /* "#utility.yul":1119:1156   */
  swap1
  pop
    /* "#utility.yul":1056:1163   */
  swap3
  swap2
  pop
  pop
  jump	// out
    /* "#utility.yul":1169:1562   */
tag_24:
    /* "#utility.yul":1238:1244   */
  0x00
    /* "#utility.yul":1288:1289   */
  0x08
    /* "#utility.yul":1276:1286   */
  dup4
    /* "#utility.yul":1272:1290   */
  mul
    /* "#utility.yul":1311:1408   */
  tag_50
    /* "#utility.yul":1341:1407   */
  0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    /* "#utility.yul":1330:1339   */
  dup3
    /* "#utility.yul":1311:1408   */
  tag_23
  jump	// in
tag_50:
    /* "#utility.yul":1429:1468   */
  tag_51
    /* "#utility.yul":1459:1467   */
  dup7
    /* "#utility.yul":1448:1457   */
  dup4
    /* "#utility.yul":1429:1468   */
  tag_23
  jump	// in
tag_51:
    /* "#utility.yul":1417:1468   */
  swap6
  pop
    /* "#utility.yul":1501:1505   */
  dup1
    /* "#utility.yul":1497:1506   */
  not
    /* "#utility.yul":1490:1495   */
  dup5
    /* "#utility.yul":1486:1507   */
  and
    /* "#utility.yul":1477:1507   */
  swap4
  pop
    /* "#utility.yul":1550:1554   */
  dup1
    /* "#utility.yul":1540:1548   */
  dup7
    /* "#utility.yul":1536:1555   */
  and
    /* "#utility.yul":1529:1534   */
  dup5
    /* "#utility.yul":1526:1556   */
  or
    /* "#utility.yul":1516:1556   */
  swap3
  pop
    /* "#utility.yul":1245:1562   */
  pop
  pop
    /* "#utility.yul":1169:1562   */
  swap4
  swap3
  pop
  pop
  pop
  jump	// out
    /* "#utility.yul":1568:1645   */
tag_25:
    /* "#utility.yul":1605:1612   */
  0x00
    /* "#utility.yul":1634:1639   */
  dup2
    /* "#utility.yul":1623:1639   */
  swap1
  pop
    /* "#utility.yul":1568:1645   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":1651:1711   */
tag_26:
    /* "#utility.yul":1679:1682   */
  0x00
    /* "#utility.yul":1700:1705   */
  dup2
    /* "#utility.yul":1693:1705   */
  swap1
  pop
    /* "#utility.yul":1651:1711   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":1717:1859   */
tag_27:
    /* "#utility.yul":1767:1776   */
  0x00
    /* "#utility.yul":1800:1853   */
  tag_55
    /* "#utility.yul":1818:1852   */
  tag_56
    /* "#utility.yul":1827:1851   */
  tag_57
    /* "#utility.yul":1845:1850   */
  dup5
    /* "#utility.yul":1827:1851   */
  tag_25
  jump	// in
tag_57:
    /* "#utility.yul":1818:1852   */
  tag_26
  jump	// in
tag_56:
    /* "#utility.yul":1800:1853   */
  tag_25
  jump	// in
tag_55:
    /* "#utility.yul":1787:1853   */
  swap1
  pop
    /* "#utility.yul":1717:1859   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":1865:1940   */
tag_28:
    /* "#utility.yul":1908:1911   */
  0x00
    /* "#utility.yul":1929:1934   */
  dup2
    /* "#utility.yul":1922:1934   */
  swap1
  pop
    /* "#utility.yul":1865:1940   */
  swap2
  swap1
  pop
  jump	// out
    /* "#utility.yul":1946:2215   */
tag_29:
    /* "#utility.yul":2056:2095   */
  tag_60
    /* "#utility.yul":2087:2094   */
  dup4
    /* "#utility.yul":2056:2095   */
  tag_27
  jump	// in
tag_60:
    /* "#utility.yul":2117:2208   */
  tag_61
    /* "#utility.yul":2166:2207   */
  tag_62
    /* "#utility.yul":2190:2206   */
  dup3
    /* "#utility.yul":2166:2207   */
  tag_28
  jump	// in
tag_62:
    /* "#utility.yul":2158:2164   */
  dup5
    /* "#utility.yul":2151:2155   */
  dup5
    /* "#utility.yul":2145:2156   */
  sload
    /* "#utility.yul":2117:2208   */
  tag_24
  jump	// in
tag_61:
    /* "#utility.yul":2111:2115   */
  dup3
    /* "#utility.yul":2104:2209   */
  sstore
    /* "#utility.yul":2022:2215   */
  pop
    /* "#utility.yul":1946:2215   */
  pop
  pop
  pop
  jump	// out
    /* "#utility.yul":2221:2294   */
tag_30:
    /* "#utility.yul":2266:2269   */
  0x00
    /* "#utility.yul":2221:2294   */
  swap1
  jump	// out
    /* "#utility.yul":2300:2489   */
tag_31:
    /* "#utility.yul":2377:2409   */
  tag_65
  tag_30
  jump	// in
tag_65:
    /* "#utility.yul":2418:2483   */
  tag_66
    /* "#utility.yul":2476:2482   */
  dup2
    /* "#utility.yul":2468:2474   */
  dup5
    /* "#utility.yul":2462:2466   */
  dup5
    /* "#utility.yul":2418:2483   */
  tag_29
  jump	// in
tag_66:
    /* "#utility.yul":2353:2489   */
  pop
    /* "#utility.yul":2300:2489   */
  pop
  pop
  jump	// out
    /* "#utility.yul":2495:2681   */
tag_32:
    /* "#utility.yul":2555:2675   */
tag_68:
    /* "#utility.yul":2572:2575   */
  dup2
    /* "#utility.yul":2565:2570   */
  dup2
    /* "#utility.yul":2562:2576   */
  lt
    /* "#utility.yul":2555:2675   */
  iszero
  tag_70
  jumpi
    /* "#utility.yul":2626:2665   */
  tag_71
    /* "#utility.yul":2663:2664   */
  0x00
    /* "#utility.yul":2656:2661   */
  dup3
    /* "#utility.yul":2626:2665   */
  tag_31
  jump	// in
tag_71:
    /* "#utility.yul":2599:2600   */
  0x01
    /* "#utility.yul":2592:2597   */
  dup2
    /* "#utility.yul":2588:2601   */
  add
    /* "#utility.yul":2579:2601   */
  swap1
  pop
    /* "#utility.yul":2555:2675   */
  jump(tag_68)
tag_70:
    /* "#utility.yul":2495:2681   */
  pop
  pop
  jump	// out
    /* "#utility.yul":2687:3230   */
tag_33:
    /* "#utility.yul":2788:2790   */
  0x1f
    /* "#utility.yul":2783:2786   */
  dup3
    /* "#utility.yul":2780:2791   */
  gt
    /* "#utility.yul":2777:3223   */
  iszero
  tag_73
  jumpi
    /* "#utility.yul":2822:2860   */
  tag_74
    /* "#utility.yul":2854:2859   */
  dup2
    /* "#utility.yul":2822:2860   */
  tag_21
  jump	// in
tag_74:
    /* "#utility.yul":2906:2935   */
  tag_75
    /* "#utility.yul":2924:2934   */
  dup5
    /* "#utility.yul":2906:2935   */
  tag_22
  jump	// in
tag_75:
    /* "#utility.yul":2896:2904   */
  dup2
    /* "#utility.yul":2892:2936   */
  add
    /* "#utility.yul":3089:3091   */
  0x20
    /* "#utility.yul":3077:3087   */
  dup6
    /* "#utility.yul":3074:3092   */
  lt
    /* "#utility.yul":3071:3120   */
  iszero
  tag_76
  jumpi
    /* "#utility.yul":3110:3118   */
  dup2
    /* "#utility.yul":3095:3118   */
  swap1
  pop
    /* "#utility.yul":3071:3120   */
tag_76:
    /* "#utility.yul":3133:3213   */
  tag_77
    /* "#utility.yul":3189:3211   */
  tag_78
    /* "#utility.yul":3207:3210   */
  dup6
    /* "#utility.yul":3189:3211   */
  tag_22
  jump	// in
tag_78:
    /* "#utility.yul":3179:3187   */
  dup4
    /* "#utility.yul":3175:3212   */
  add
    /* "#utility.yul":3162:3173   */
  dup3
    /* "#utility.yul":3133:3213   */
  tag_32
  jump	// in
tag_77:
    /* "#utility.yul":2792:3223   */
  pop
  pop
    /* "#utility.yul":2777:3223   */
tag_73:
    /* "#utility.yul":2687:3230   */
  pop
  pop
  pop
  jump	// out
    /* "#utility.yul":3236:3353   */
tag_34:
    /* "#utility.yul":3290:3298   */
  0x00
    /* "#utility.yul":3340:3345   */
  dup3
    /* "#utility.yul":3334:3338   */
  dup3
    /* "#utility.yul":3330:3346   */
  shr
    /* "#utility.yul":3309:3346   */
  swap1
  pop
    /* "#utility.yul":3236:3353   */
  swap3
  swap2
  pop
  pop
  jump	// out
    /* "#utility.yul":3359:3528   */
tag_35:
    /* "#utility.yul":3403:3409   */
  0x00
    /* "#utility.yul":3436:3487   */
  tag_81
    /* "#utility.yul":3484:3485   */
  0x00
    /* "#utility.yul":3480:3486   */
  not
    /* "#utility.yul":3472:3477   */
  dup5
    /* "#utility.yul":3469:3470   */
  0x08
    /* "#utility.yul":3465:3478   */
  mul
    /* "#utility.yul":3436:3487   */
  tag_34
  jump	// in
tag_81:
    /* "#utility.yul":3432:3488   */
  not
    /* "#utility.yul":3517:3521   */
  dup1
    /* "#utility.yul":3511:3515   */
  dup4
    /* "#utility.yul":3507:3522   */
  and
    /* "#utility.yul":3497:3522   */
  swap2
  pop
    /* "#utility.yul":3410:3528   */
  pop
    /* "#utility.yul":3359:3528   */
  swap3
  swap2
  pop
  pop
  jump	// out
    /* "#utility.yul":3533:3828   */
tag_36:
    /* "#utility.yul":3609:3613   */
  0x00
    /* "#utility.yul":3755:3784   */
  tag_83
    /* "#utility.yul":3780:3783   */
  dup4
    /* "#utility.yul":3774:3778   */
  dup4
    /* "#utility.yul":3755:3784   */
  tag_35
  jump	// in
tag_83:
    /* "#utility.yul":3747:3784   */
  swap2
  pop
    /* "#utility.yul":3817:3820   */
  dup3
    /* "#utility.yul":3814:3815   */
  0x02
    /* "#utility.yul":3810:3821   */
  mul
    /* "#utility.yul":3804:3808   */
  dup3
    /* "#utility.yul":3801:3822   */
  or
    /* "#utility.yul":3793:3822   */
  swap1
  pop
    /* "#utility.yul":3533:3828   */
  swap3
  swap2
  pop
  pop
  jump	// out
    /* "#utility.yul":3833:5228   */
tag_14:
    /* "#utility.yul":3950:3987   */
  tag_85
    /* "#utility.yul":3983:3986   */
  dup3
    /* "#utility.yul":3950:3987   */
  tag_17
  jump	// in
tag_85:
    /* "#utility.yul":4052:4070   */
  0xffffffffffffffff
    /* "#utility.yul":4044:4050   */
  dup2
    /* "#utility.yul":4041:4071   */
  gt
    /* "#utility.yul":4038:4094   */
  iszero
  tag_86
  jumpi
    /* "#utility.yul":4074:4092   */
  tag_87
  tag_18
  jump	// in
tag_87:
    /* "#utility.yul":4038:4094   */
tag_86:
    /* "#utility.yul":4118:4156   */
  tag_88
    /* "#utility.yul":4150:4154   */
  dup3
    /* "#utility.yul":4144:4155   */
  sload
    /* "#utility.yul":4118:4156   */
  tag_20
  jump	// in
tag_88:
    /* "#utility.yul":4203:4270   */
  tag_89
    /* "#utility.yul":4263:4269   */
  dup3
    /* "#utility.yul":4255:4261   */
  dup3
    /* "#utility.yul":4249:4253   */
  dup6
    /* "#utility.yul":4203:4270   */
  tag_33
  jump	// in
tag_89:
    /* "#utility.yul":4297:4298   */
  0x00
    /* "#utility.yul":4321:4325   */
  0x20
    /* "#utility.yul":4308:4325   */
  swap1
  pop
    /* "#utility.yul":4353:4355   */
  0x1f
    /* "#utility.yul":4345:4351   */
  dup4
    /* "#utility.yul":4342:4356   */
  gt
    /* "#utility.yul":4370:4371   */
  0x01
    /* "#utility.yul":4365:4983   */
  dup2
  eq
  tag_91
  jumpi
    /* "#utility.yul":5027:5028   */
  0x00
    /* "#utility.yul":5044:5050   */
  dup5
    /* "#utility.yul":5041:5118   */
  iszero
  tag_92
  jumpi
    /* "#utility.yul":5093:5102   */
  dup3
    /* "#utility.yul":5088:5091   */
  dup8
    /* "#utility.yul":5084:5103   */
  add
    /* "#utility.yul":5078:5104   */
  mload
    /* "#utility.yul":5069:5104   */
  swap1
  pop
    /* "#utility.yul":5041:5118   */
tag_92:
    /* "#utility.yul":5144:5211   */
  tag_93
    /* "#utility.yul":5204:5210   */
  dup6
    /* "#utility.yul":5197:5202   */
  dup3
    /* "#utility.yul":5144:5211   */
  tag_36
  jump	// in
tag_93:
    /* "#utility.yul":5138:5142   */
  dup7
    /* "#utility.yul":5131:5212   */
  sstore
    /* "#utility.yul":5000:5222   */
  pop
    /* "#utility.yul":4335:5222   */
  jump(tag_90)
    /* "#utility.yul":4365:4983   */
tag_91:
    /* "#utility.yul":4417:4421   */
  0x1f
    /* "#utility.yul":4413:4422   */
  not
    /* "#utility.yul":4405:4411   */
  dup5
    /* "#utility.yul":4401:4423   */
  and
    /* "#utility.yul":4451:4488   */
  tag_94
    /* "#utility.yul":4483:4487   */
  dup7
    /* "#utility.yul":4451:4488   */
  tag_21
  jump	// in
tag_94:
    /* "#utility.yul":4510:4511   */
  0x00
    /* "#utility.yul":4524:4732   */
tag_95:
    /* "#utility.yul":4538:4545   */
  dup3
    /* "#utility.yul":4535:4536   */
  dup2
    /* "#utility.yul":4532:4546   */
  lt
    /* "#utility.yul":4524:4732   */
  iszero
  tag_97
  jumpi
    /* "#utility.yul":4617:4626   */
  dup5
    /* "#utility.yul":4612:4615   */
  dup10
    /* "#utility.yul":4608:4627   */
  add
    /* "#utility.yul":4602:4628   */
  mload
    /* "#utility.yul":4594:4600   */
  dup3
    /* "#utility.yul":4587:4629   */
  sstore
    /* "#utility.yul":4668:4669   */
  0x01
    /* "#utility.yul":4660:4666   */
  dup3
    /* "#utility.yul":4656:4670   */
  add
    /* "#utility.yul":4646:4670   */
  swap2
  pop
    /* "#utility.yul":4715:4717   */
  0x20
    /* "#utility.yul":4704:4713   */
  dup6
    /* "#utility.yul":4700:4718   */
  add
    /* "#utility.yul":4687:4718   */
  swap5
  pop
    /* "#utility.yul":4561:4565   */
  0x20
    /* "#utility.yul":4558:4559   */
  dup2
    /* "#utility.yul":4554:4566   */
  add
    /* "#utility.yul":4549:4566   */
  swap1
  pop
    /* "#utility.yul":4524:4732   */
  jump(tag_95)
tag_97:
    /* "#utility.yul":4760:4766   */
  dup7
    /* "#utility.yul":4751:4758   */
  dup4
    /* "#utility.yul":4748:4767   */
  lt
    /* "#utility.yul":4745:4924   */
  iszero
  tag_98
  jumpi
    /* "#utility.yul":4818:4827   */
  dup5
    /* "#utility.yul":4813:4816   */
  dup10
    /* "#utility.yul":4809:4828   */
  add
    /* "#utility.yul":4803:4829   */
  mload
    /* "#utility.yul":4861:4909   */
  tag_99
    /* "#utility.yul":4903:4907   */
  0x1f
    /* "#utility.yul":4895:4901   */
  dup10
    /* "#utility.yul":4891:4908   */
  and
    /* "#utility.yul":4880:4889   */
  dup3
    /* "#utility.yul":4861:4909   */
  tag_35
  jump	// in
tag_99:
    /* "#utility.yul":4853:4859   */
  dup4
    /* "#utility.yul":4846:4910   */
  sstore
    /* "#utility.yul":4768:4924   */
  pop
    /* "#utility.yul":4745:4924   */
tag_98:
    /* "#utility.yul":4970:4971   */
  0x01
    /* "#utility.yul":4966:4967   */
  0x02
    /* "#utility.yul":4958:4964   */
  dup9
    /* "#utility.yul":4954:4968   */
  mul
    /* "#utility.yul":4950:4972   */
  add
    /* "#utility.yul":4944:4948   */
  dup9
    /* "#utility.yul":4937:4973   */
  sstore
    /* "#utility.yul":4372:4983   */
  pop
  pop
  pop
    /* "#utility.yul":4335:5222   */
tag_90:
  pop
    /* "#utility.yul":3925:5228   */
  pop
  pop
  pop
    /* "#utility.yul":3833:5228   */
  pop
  pop
  jump	// out
    /* "#utility.yul":5234:5414   */
tag_37:
    /* "#utility.yul":5282:5359   */
  0x4e487b7100000000000000000000000000000000000000000000000000000000
    /* "#utility.yul":5279:5280   */
  0x00
    /* "#utility.yul":5272:5360   */
  mstore
    /* "#utility.yul":5379:5383   */
  0x11
    /* "#utility.yul":5376:5377   */
  0x04
    /* "#utility.yul":5369:5384   */
  mstore
    /* "#utility.yul":5403:5407   */
  0x24
    /* "#utility.yul":5400:5401   */
  0x00
    /* "#utility.yul":5393:5408   */
  revert
    /* "#utility.yul":5420:5653   */
tag_16:
    /* "#utility.yul":5459:5462   */
  0x00
    /* "#utility.yul":5482:5506   */
  tag_102
    /* "#utility.yul":5500:5505   */
  dup3
    /* "#utility.yul":5482:5506   */
  tag_25
  jump	// in
tag_102:
    /* "#utility.yul":5473:5506   */
  swap2
  pop
    /* "#utility.yul":5528:5594   */
  0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    /* "#utility.yul":5521:5526   */
  dup3
    /* "#utility.yul":5518:5595   */
  sub
    /* "#utility.yul":5515:5618   */
  tag_103
  jumpi
    /* "#utility.yul":5598:5616   */
  tag_104
  tag_37
  jump	// in
tag_104:
    /* "#utility.yul":5515:5618   */
tag_103:
    /* "#utility.yul":5645:5646   */
  0x01
    /* "#utility.yul":5638:5643   */
  dup3
    /* "#utility.yul":5634:5647   */
  add
    /* "#utility.yul":5627:5647   */
  swap1
  pop
    /* "#utility.yul":5420:5653   */
  swap2
  swap1
  pop
  jump	// out
    /* "Poll.sol":270:4220  contract Poll is IPoll {... */
tag_11:
  dataSize(sub_0)
  dup1
  dataOffset(sub_0)
  0x00
  codecopy
  0x00
  return
stop

sub_0: assembly {
        /* "Poll.sol":270:4220  contract Poll is IPoll {... */
      mstore(0x40, 0x80)
      callvalue
      dup1
      iszero
      tag_1
      jumpi
      0x00
      dup1
      revert
    tag_1:
      pop
      jumpi(tag_2, lt(calldatasize, 0x04))
      shr(0xe0, calldataload(0x00))
      dup1
      0x70740aab
      gt
      tag_11
      jumpi
      dup1
      0x70740aab
      eq
      tag_7
      jumpi
      dup1
      0xaec2ccae
      eq
      tag_8
      jumpi
      dup1
      0xdc899a07
      eq
      tag_9
      jumpi
      dup1
      0xf6fd7fde
      eq
      tag_10
      jumpi
      jump(tag_2)
    tag_11:
      dup1
      0x0121b93f
      eq
      tag_3
      jumpi
      dup1
      0x01ffc9a7
      eq
      tag_4
      jumpi
      dup1
      0x251760b7
      eq
      tag_5
      jumpi
      dup1
      0x5fa520bb
      eq
      tag_6
      jumpi
    tag_2:
      0x00
      dup1
      revert
        /* "Poll.sol":3217:3466  function vote (uint _id) public override {... */
    tag_3:
      tag_12
      0x04
      dup1
      calldatasize
      sub
      dup2
      add
      swap1
      tag_13
      swap2
      swap1
      tag_14
      jump	// in
    tag_13:
      tag_15
      jump	// in
    tag_12:
      stop
        /* "Poll.sol":4050:4217  function supportsInterface(bytes4 interfaceId) external override pure returns (bool) {... */
    tag_4:
      tag_16
      0x04
      dup1
      calldatasize
      sub
      dup2
      add
      swap1
      tag_17
      swap2
      swap1
      tag_18
      jump	// in
    tag_17:
      tag_19
      jump	// in
    tag_16:
      mload(0x40)
      tag_20
      swap2
      swap1
      tag_21
      jump	// in
    tag_20:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":1951:1983  uint public override num_choices */
    tag_5:
      tag_22
      tag_23
      jump	// in
    tag_22:
      mload(0x40)
      tag_24
      swap2
      swap1
      tag_25
      jump	// in
    tag_24:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":2814:2987  function addChoice (string memory _name) public override {... */
    tag_6:
      tag_26
      0x04
      dup1
      calldatasize
      sub
      dup2
      add
      swap1
      tag_27
      swap2
      swap1
      tag_28
      jump	// in
    tag_27:
      tag_29
      jump	// in
    tag_26:
      stop
        /* "Poll.sol":2247:2318  string public override constant purpose = "Vote on your favorite color" */
    tag_7:
      tag_30
      tag_31
      jump	// in
    tag_30:
      mload(0x40)
      tag_32
      swap2
      swap1
      tag_33
      jump	// in
    tag_32:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":953:1000  mapping (address => bool) public override voted */
    tag_8:
      tag_34
      0x04
      dup1
      calldatasize
      sub
      dup2
      add
      swap1
      tag_35
      swap2
      swap1
      tag_36
      jump	// in
    tag_35:
      tag_37
      jump	// in
    tag_34:
      mload(0x40)
      tag_38
      swap2
      swap1
      tag_21
      jump	// in
    tag_38:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":3726:3824  function unnecessaryFunction() public view returns (string memory) {... */
    tag_9:
      tag_39
      tag_40
      jump	// in
    tag_39:
      mload(0x40)
      tag_41
      swap2
      swap1
      tag_33
      jump	// in
    tag_41:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":1609:1705  function choices(uint i) public view override returns (Choice memory) {... */
    tag_10:
      tag_42
      0x04
      dup1
      calldatasize
      sub
      dup2
      add
      swap1
      tag_43
      swap2
      swap1
      tag_14
      jump	// in
    tag_43:
      tag_44
      jump	// in
    tag_42:
      mload(0x40)
      tag_45
      swap2
      swap1
      tag_46
      jump	// in
    tag_45:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      return
        /* "Poll.sol":3217:3466  function vote (uint _id) public override {... */
    tag_15:
        /* "Poll.sol":3271:3276  voted */
      0x00
        /* "Poll.sol":3271:3288  voted[msg.sender] */
      dup1
        /* "Poll.sol":3277:3287  msg.sender */
      caller
        /* "Poll.sol":3271:3288  voted[msg.sender] */
      0xffffffffffffffffffffffffffffffffffffffff
      and
      0xffffffffffffffffffffffffffffffffffffffff
      and
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
      0x00
      swap1
      sload
      swap1
      0x0100
      exp
      swap1
      div
      0xff
      and
        /* "Poll.sol":3270:3288  !voted[msg.sender] */
      iszero
        /* "Poll.sol":3262:3317  require(!voted[msg.sender], "sender has already voted") */
      tag_48
      jumpi
      mload(0x40)
      0x08c379a000000000000000000000000000000000000000000000000000000000
      dup2
      mstore
      0x04
      add
      tag_49
      swap1
      tag_50
      jump	// in
    tag_49:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      revert
    tag_48:
        /* "Poll.sol":3336:3337  0 */
      0x00
        /* "Poll.sol":3329:3332  _id */
      dup2
        /* "Poll.sol":3329:3337  _id >= 0 */
      lt
      iszero
        /* "Poll.sol":3329:3358  _id >= 0 && _id < num_choices */
      dup1
      iszero
      tag_51
      jumpi
      pop
        /* "Poll.sol":3347:3358  num_choices */
      sload(0x02)
        /* "Poll.sol":3341:3344  _id */
      dup2
        /* "Poll.sol":3341:3358  _id < num_choices */
      lt
        /* "Poll.sol":3329:3358  _id >= 0 && _id < num_choices */
    tag_51:
        /* "Poll.sol":3321:3385  require(_id >= 0 && _id < num_choices, "invalid vote selection") */
      tag_52
      jumpi
      mload(0x40)
      0x08c379a000000000000000000000000000000000000000000000000000000000
      dup2
      mstore
      0x04
      add
      tag_53
      swap1
      tag_54
      jump	// in
    tag_53:
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      revert
    tag_52:
        /* "Poll.sol":3409:3413  true */
      0x01
        /* "Poll.sol":3389:3394  voted */
      0x00
        /* "Poll.sol":3389:3406  voted[msg.sender] */
      dup1
        /* "Poll.sol":3395:3405  msg.sender */
      caller
        /* "Poll.sol":3389:3406  voted[msg.sender] */
      0xffffffffffffffffffffffffffffffffffffffff
      and
      0xffffffffffffffffffffffffffffffffffffffff
      and
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
      0x00
        /* "Poll.sol":3389:3413  voted[msg.sender] = true */
      0x0100
      exp
      dup2
      sload
      dup2
      0xff
      mul
      not
      and
      swap1
      dup4
      iszero
      iszero
      mul
      or
      swap1
      sstore
      pop
        /* "Poll.sol":3417:3425  _choices */
      0x01
        /* "Poll.sol":3417:3430  _choices[_id] */
      0x00
        /* "Poll.sol":3426:3429  _id */
      dup3
        /* "Poll.sol":3417:3430  _choices[_id] */
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
        /* "Poll.sol":3417:3436  _choices[_id].votes */
      0x02
      add
      0x00
        /* "Poll.sol":3417:3438  _choices[_id].votes++ */
      dup2
      sload
      dup1
      swap3
      swap2
      swap1
      tag_55
      swap1
      tag_56
      jump	// in
    tag_55:
      swap2
      swap1
      pop
      sstore
      pop
        /* "Poll.sol":3458:3461  _id */
      dup1
        /* "Poll.sol":3447:3462  votedEvent(_id) */
      0xfff3c900d938d21d0990d786e819f29b8d05c1ef587b462b939609625b684b16
      mload(0x40)
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      log2
        /* "Poll.sol":3217:3466  function vote (uint _id) public override {... */
      pop
      jump	// out
        /* "Poll.sol":4050:4217  function supportsInterface(bytes4 interfaceId) external override pure returns (bool) {... */
    tag_19:
        /* "Poll.sol":4129:4133  bool */
      0x00
        /* "Poll.sol":4161:4184  type(IPoll).interfaceId */
      0x5227894f00000000000000000000000000000000000000000000000000000000
        /* "Poll.sol":4146:4184  interfaceId == type(IPoll).interfaceId */
      not(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
      and
        /* "Poll.sol":4146:4157  interfaceId */
      dup3
        /* "Poll.sol":4146:4184  interfaceId == type(IPoll).interfaceId */
      not(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
      and
      eq
        /* "Poll.sol":4146:4213  interfaceId == type(IPoll).interfaceId || interfaceId == 0x01ffc9a7 */
      dup1
      tag_58
      jumpi
      pop
        /* "Poll.sol":4203:4213  0x01ffc9a7 */
      0x01ffc9a7
        /* "Poll.sol":4188:4213  interfaceId == 0x01ffc9a7 */
      0xe0
      shl
        /* "Poll.sol":4188:4199  interfaceId */
      dup3
        /* "Poll.sol":4188:4213  interfaceId == 0x01ffc9a7 */
      not(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
      and
      eq
        /* "Poll.sol":4146:4213  interfaceId == type(IPoll).interfaceId || interfaceId == 0x01ffc9a7 */
    tag_58:
        /* "Poll.sol":4139:4213  return interfaceId == type(IPoll).interfaceId || interfaceId == 0x01ffc9a7 */
      swap1
      pop
        /* "Poll.sol":4050:4217  function supportsInterface(bytes4 interfaceId) external override pure returns (bool) {... */
      swap2
      swap1
      pop
      jump	// out
        /* "Poll.sol":1951:1983  uint public override num_choices */
    tag_23:
      sload(0x02)
      dup2
      jump	// out
        /* "Poll.sol":2814:2987  function addChoice (string memory _name) public override {... */
    tag_29:
        /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
      mload(0x40)
      dup1
      0x60
      add
      0x40
      mstore
      dup1
        /* "Poll.sol":2906:2917  num_choices */
      sload(0x02)
        /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
      dup2
      mstore
      0x20
      add
        /* "Poll.sol":2919:2924  _name */
      dup3
        /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
      dup2
      mstore
      0x20
      add
        /* "Poll.sol":2926:2927  0 */
      0x00
        /* "Poll.sol":2899:2928  Choice(num_choices, _name, 0) */
      dup2
      mstore
      pop
        /* "Poll.sol":2875:2883  _choices */
      0x01
        /* "Poll.sol":2875:2896  _choices[num_choices] */
      0x00
        /* "Poll.sol":2884:2895  num_choices */
      sload(0x02)
        /* "Poll.sol":2875:2896  _choices[num_choices] */
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
        /* "Poll.sol":2875:2928  _choices[num_choices] = Choice(num_choices, _name, 0) */
      0x00
      dup3
      add
      mload
      dup2
      0x00
      add
      sstore
      0x20
      dup3
      add
      mload
      dup2
      0x01
      add
      swap1
      dup2
      tag_60
      swap2
      swap1
      tag_61
      jump	// in
    tag_60:
      pop
      0x40
      dup3
      add
      mload
      dup2
      0x02
      add
      sstore
      swap1
      pop
      pop
        /* "Poll.sol":2954:2965  num_choices */
      sload(0x02)
        /* "Poll.sol":2937:2966  choiceAddedEvent(num_choices) */
      0x8c289382d6fd42a02a06e885da5a69cb0f21294bbfc7acc91d5cf3ced61ca0c4
      mload(0x40)
      mload(0x40)
      dup1
      swap2
      sub
      swap1
      log2
        /* "Poll.sol":2970:2981  num_choices */
      0x02
      0x00
        /* "Poll.sol":2970:2983  num_choices++ */
      dup2
      sload
      dup1
      swap3
      swap2
      swap1
      tag_62
      swap1
      tag_56
      jump	// in
    tag_62:
      swap2
      swap1
      pop
      sstore
      pop
        /* "Poll.sol":2814:2987  function addChoice (string memory _name) public override {... */
      pop
      jump	// out
        /* "Poll.sol":2247:2318  string public override constant purpose = "Vote on your favorite color" */
    tag_31:
      mload(0x40)
      dup1
      0x40
      add
      0x40
      mstore
      dup1
      0x1b
      dup2
      mstore
      0x20
      add
      0x566f7465206f6e20796f7572206661766f7269746520636f6c6f720000000000
      dup2
      mstore
      pop
      dup2
      jump	// out
        /* "Poll.sol":953:1000  mapping (address => bool) public override voted */
    tag_37:
      mstore(0x20, 0x00)
      dup1
      0x00
      mstore
      keccak256(0x00, 0x40)
      0x00
      swap2
      pop
      sload
      swap1
      0x0100
      exp
      swap1
      div
      0xff
      and
      dup2
      jump	// out
        /* "Poll.sol":3726:3824  function unnecessaryFunction() public view returns (string memory) {... */
    tag_40:
        /* "Poll.sol":3778:3791  string memory */
      0x60
        /* "Poll.sol":3804:3812  _choices */
      0x01
        /* "Poll.sol":3804:3815  _choices[0] */
      0x00
        /* "Poll.sol":3813:3814  0 */
      dup1
        /* "Poll.sol":3804:3815  _choices[0] */
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
        /* "Poll.sol":3804:3820  _choices[0].name */
      0x01
      add
        /* "Poll.sol":3797:3820  return _choices[0].name */
      dup1
      sload
      tag_64
      swap1
      tag_65
      jump	// in
    tag_64:
      dup1
      0x1f
      add
      0x20
      dup1
      swap2
      div
      mul
      0x20
      add
      mload(0x40)
      swap1
      dup2
      add
      0x40
      mstore
      dup1
      swap3
      swap2
      swap1
      dup2
      dup2
      mstore
      0x20
      add
      dup3
      dup1
      sload
      tag_66
      swap1
      tag_65
      jump	// in
    tag_66:
      dup1
      iszero
      tag_67
      jumpi
      dup1
      0x1f
      lt
      tag_68
      jumpi
      0x0100
      dup1
      dup4
      sload
      div
      mul
      dup4
      mstore
      swap2
      0x20
      add
      swap2
      jump(tag_67)
    tag_68:
      dup3
      add
      swap2
      swap1
      0x00
      mstore
      keccak256(0x00, 0x20)
      swap1
    tag_69:
      dup2
      sload
      dup2
      mstore
      swap1
      0x01
      add
      swap1
      0x20
      add
      dup1
      dup4
      gt
      tag_69
      jumpi
      dup3
      swap1
      sub
      0x1f
      and
      dup3
      add
      swap2
    tag_67:
      pop
      pop
      pop
      pop
      pop
      swap1
      pop
        /* "Poll.sol":3726:3824  function unnecessaryFunction() public view returns (string memory) {... */
      swap1
      jump	// out
        /* "Poll.sol":1609:1705  function choices(uint i) public view override returns (Choice memory) {... */
    tag_44:
        /* "Poll.sol":1664:1677  Choice memory */
      tag_70
      tag_71
      jump	// in
    tag_70:
        /* "Poll.sol":1690:1698  _choices */
      0x01
        /* "Poll.sol":1690:1701  _choices[i] */
      0x00
        /* "Poll.sol":1699:1700  i */
      dup4
        /* "Poll.sol":1690:1701  _choices[i] */
      dup2
      mstore
      0x20
      add
      swap1
      dup2
      mstore
      0x20
      add
      0x00
      keccak256
        /* "Poll.sol":1683:1701  return _choices[i] */
      mload(0x40)
      dup1
      0x60
      add
      0x40
      mstore
      swap1
      dup2
      0x00
      dup3
      add
      sload
      dup2
      mstore
      0x20
      add
      0x01
      dup3
      add
      dup1
      sload
      tag_73
      swap1
      tag_65
      jump	// in
    tag_73:
      dup1
      0x1f
      add
      0x20
      dup1
      swap2
      div
      mul
      0x20
      add
      mload(0x40)
      swap1
      dup2
      add
      0x40
      mstore
      dup1
      swap3
      swap2
      swap1
      dup2
      dup2
      mstore
      0x20
      add
      dup3
      dup1
      sload
      tag_74
      swap1
      tag_65
      jump	// in
    tag_74:
      dup1
      iszero
      tag_75
      jumpi
      dup1
      0x1f
      lt
      tag_76
      jumpi
      0x0100
      dup1
      dup4
      sload
      div
      mul
      dup4
      mstore
      swap2
      0x20
      add
      swap2
      jump(tag_75)
    tag_76:
      dup3
      add
      swap2
      swap1
      0x00
      mstore
      keccak256(0x00, 0x20)
      swap1
    tag_77:
      dup2
      sload
      dup2
      mstore
      swap1
      0x01
      add
      swap1
      0x20
      add
      dup1
      dup4
      gt
      tag_77
      jumpi
      dup3
      swap1
      sub
      0x1f
      and
      dup3
      add
      swap2
    tag_75:
      pop
      pop
      pop
      pop
      pop
      dup2
      mstore
      0x20
      add
      0x02
      dup3
      add
      sload
      dup2
      mstore
      pop
      pop
      swap1
      pop
        /* "Poll.sol":1609:1705  function choices(uint i) public view override returns (Choice memory) {... */
      swap2
      swap1
      pop
      jump	// out
    tag_71:
      mload(0x40)
      dup1
      0x60
      add
      0x40
      mstore
      dup1
      0x00
      dup2
      mstore
      0x20
      add
      0x60
      dup2
      mstore
      0x20
      add
      0x00
      dup2
      mstore
      pop
      swap1
      jump	// out
        /* "#utility.yul":7:82   */
    tag_78:
        /* "#utility.yul":40:46   */
      0x00
        /* "#utility.yul":73:75   */
      0x40
        /* "#utility.yul":67:76   */
      mload
        /* "#utility.yul":57:76   */
      swap1
      pop
        /* "#utility.yul":7:82   */
      swap1
      jump	// out
        /* "#utility.yul":88:205   */
    tag_79:
        /* "#utility.yul":197:198   */
      0x00
        /* "#utility.yul":194:195   */
      dup1
        /* "#utility.yul":187:199   */
      revert
        /* "#utility.yul":211:328   */
    tag_80:
        /* "#utility.yul":320:321   */
      0x00
        /* "#utility.yul":317:318   */
      dup1
        /* "#utility.yul":310:322   */
      revert
        /* "#utility.yul":334:411   */
    tag_81:
        /* "#utility.yul":371:378   */
      0x00
        /* "#utility.yul":400:405   */
      dup2
        /* "#utility.yul":389:405   */
      swap1
      pop
        /* "#utility.yul":334:411   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":417:539   */
    tag_82:
        /* "#utility.yul":490:514   */
      tag_139
        /* "#utility.yul":508:513   */
      dup2
        /* "#utility.yul":490:514   */
      tag_81
      jump	// in
    tag_139:
        /* "#utility.yul":483:488   */
      dup2
        /* "#utility.yul":480:515   */
      eq
        /* "#utility.yul":470:533   */
      tag_140
      jumpi
        /* "#utility.yul":529:530   */
      0x00
        /* "#utility.yul":526:527   */
      dup1
        /* "#utility.yul":519:531   */
      revert
        /* "#utility.yul":470:533   */
    tag_140:
        /* "#utility.yul":417:539   */
      pop
      jump	// out
        /* "#utility.yul":545:684   */
    tag_83:
        /* "#utility.yul":591:596   */
      0x00
        /* "#utility.yul":629:635   */
      dup2
        /* "#utility.yul":616:636   */
      calldataload
        /* "#utility.yul":607:636   */
      swap1
      pop
        /* "#utility.yul":645:678   */
      tag_142
        /* "#utility.yul":672:677   */
      dup2
        /* "#utility.yul":645:678   */
      tag_82
      jump	// in
    tag_142:
        /* "#utility.yul":545:684   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":690:1019   */
    tag_14:
        /* "#utility.yul":749:755   */
      0x00
        /* "#utility.yul":798:800   */
      0x20
        /* "#utility.yul":786:795   */
      dup3
        /* "#utility.yul":777:784   */
      dup5
        /* "#utility.yul":773:796   */
      sub
        /* "#utility.yul":769:801   */
      slt
        /* "#utility.yul":766:885   */
      iszero
      tag_144
      jumpi
        /* "#utility.yul":804:883   */
      tag_145
      tag_79
      jump	// in
    tag_145:
        /* "#utility.yul":766:885   */
    tag_144:
        /* "#utility.yul":924:925   */
      0x00
        /* "#utility.yul":949:1002   */
      tag_146
        /* "#utility.yul":994:1001   */
      dup5
        /* "#utility.yul":985:991   */
      dup3
        /* "#utility.yul":974:983   */
      dup6
        /* "#utility.yul":970:992   */
      add
        /* "#utility.yul":949:1002   */
      tag_83
      jump	// in
    tag_146:
        /* "#utility.yul":939:1002   */
      swap2
      pop
        /* "#utility.yul":895:1012   */
      pop
        /* "#utility.yul":690:1019   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":1025:1174   */
    tag_84:
        /* "#utility.yul":1061:1068   */
      0x00
        /* "#utility.yul":1101:1167   */
      0xffffffff00000000000000000000000000000000000000000000000000000000
        /* "#utility.yul":1094:1099   */
      dup3
        /* "#utility.yul":1090:1168   */
      and
        /* "#utility.yul":1079:1168   */
      swap1
      pop
        /* "#utility.yul":1025:1174   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":1180:1300   */
    tag_85:
        /* "#utility.yul":1252:1275   */
      tag_149
        /* "#utility.yul":1269:1274   */
      dup2
        /* "#utility.yul":1252:1275   */
      tag_84
      jump	// in
    tag_149:
        /* "#utility.yul":1245:1250   */
      dup2
        /* "#utility.yul":1242:1276   */
      eq
        /* "#utility.yul":1232:1294   */
      tag_150
      jumpi
        /* "#utility.yul":1290:1291   */
      0x00
        /* "#utility.yul":1287:1288   */
      dup1
        /* "#utility.yul":1280:1292   */
      revert
        /* "#utility.yul":1232:1294   */
    tag_150:
        /* "#utility.yul":1180:1300   */
      pop
      jump	// out
        /* "#utility.yul":1306:1443   */
    tag_86:
        /* "#utility.yul":1351:1356   */
      0x00
        /* "#utility.yul":1389:1395   */
      dup2
        /* "#utility.yul":1376:1396   */
      calldataload
        /* "#utility.yul":1367:1396   */
      swap1
      pop
        /* "#utility.yul":1405:1437   */
      tag_152
        /* "#utility.yul":1431:1436   */
      dup2
        /* "#utility.yul":1405:1437   */
      tag_85
      jump	// in
    tag_152:
        /* "#utility.yul":1306:1443   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":1449:1776   */
    tag_18:
        /* "#utility.yul":1507:1513   */
      0x00
        /* "#utility.yul":1556:1558   */
      0x20
        /* "#utility.yul":1544:1553   */
      dup3
        /* "#utility.yul":1535:1542   */
      dup5
        /* "#utility.yul":1531:1554   */
      sub
        /* "#utility.yul":1527:1559   */
      slt
        /* "#utility.yul":1524:1643   */
      iszero
      tag_154
      jumpi
        /* "#utility.yul":1562:1641   */
      tag_155
      tag_79
      jump	// in
    tag_155:
        /* "#utility.yul":1524:1643   */
    tag_154:
        /* "#utility.yul":1682:1683   */
      0x00
        /* "#utility.yul":1707:1759   */
      tag_156
        /* "#utility.yul":1751:1758   */
      dup5
        /* "#utility.yul":1742:1748   */
      dup3
        /* "#utility.yul":1731:1740   */
      dup6
        /* "#utility.yul":1727:1749   */
      add
        /* "#utility.yul":1707:1759   */
      tag_86
      jump	// in
    tag_156:
        /* "#utility.yul":1697:1759   */
      swap2
      pop
        /* "#utility.yul":1653:1769   */
      pop
        /* "#utility.yul":1449:1776   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":1782:1872   */
    tag_87:
        /* "#utility.yul":1816:1823   */
      0x00
        /* "#utility.yul":1859:1864   */
      dup2
        /* "#utility.yul":1852:1865   */
      iszero
        /* "#utility.yul":1845:1866   */
      iszero
        /* "#utility.yul":1834:1866   */
      swap1
      pop
        /* "#utility.yul":1782:1872   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":1878:1987   */
    tag_88:
        /* "#utility.yul":1959:1980   */
      tag_159
        /* "#utility.yul":1974:1979   */
      dup2
        /* "#utility.yul":1959:1980   */
      tag_87
      jump	// in
    tag_159:
        /* "#utility.yul":1954:1957   */
      dup3
        /* "#utility.yul":1947:1981   */
      mstore
        /* "#utility.yul":1878:1987   */
      pop
      pop
      jump	// out
        /* "#utility.yul":1993:2203   */
    tag_21:
        /* "#utility.yul":2080:2084   */
      0x00
        /* "#utility.yul":2118:2120   */
      0x20
        /* "#utility.yul":2107:2116   */
      dup3
        /* "#utility.yul":2103:2121   */
      add
        /* "#utility.yul":2095:2121   */
      swap1
      pop
        /* "#utility.yul":2131:2196   */
      tag_161
        /* "#utility.yul":2193:2194   */
      0x00
        /* "#utility.yul":2182:2191   */
      dup4
        /* "#utility.yul":2178:2195   */
      add
        /* "#utility.yul":2169:2175   */
      dup5
        /* "#utility.yul":2131:2196   */
      tag_88
      jump	// in
    tag_161:
        /* "#utility.yul":1993:2203   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":2209:2327   */
    tag_89:
        /* "#utility.yul":2296:2320   */
      tag_163
        /* "#utility.yul":2314:2319   */
      dup2
        /* "#utility.yul":2296:2320   */
      tag_81
      jump	// in
    tag_163:
        /* "#utility.yul":2291:2294   */
      dup3
        /* "#utility.yul":2284:2321   */
      mstore
        /* "#utility.yul":2209:2327   */
      pop
      pop
      jump	// out
        /* "#utility.yul":2333:2555   */
    tag_25:
        /* "#utility.yul":2426:2430   */
      0x00
        /* "#utility.yul":2464:2466   */
      0x20
        /* "#utility.yul":2453:2462   */
      dup3
        /* "#utility.yul":2449:2467   */
      add
        /* "#utility.yul":2441:2467   */
      swap1
      pop
        /* "#utility.yul":2477:2548   */
      tag_165
        /* "#utility.yul":2545:2546   */
      0x00
        /* "#utility.yul":2534:2543   */
      dup4
        /* "#utility.yul":2530:2547   */
      add
        /* "#utility.yul":2521:2527   */
      dup5
        /* "#utility.yul":2477:2548   */
      tag_89
      jump	// in
    tag_165:
        /* "#utility.yul":2333:2555   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":2561:2678   */
    tag_90:
        /* "#utility.yul":2670:2671   */
      0x00
        /* "#utility.yul":2667:2668   */
      dup1
        /* "#utility.yul":2660:2672   */
      revert
        /* "#utility.yul":2684:2801   */
    tag_91:
        /* "#utility.yul":2793:2794   */
      0x00
        /* "#utility.yul":2790:2791   */
      dup1
        /* "#utility.yul":2783:2795   */
      revert
        /* "#utility.yul":2807:2909   */
    tag_92:
        /* "#utility.yul":2848:2854   */
      0x00
        /* "#utility.yul":2899:2901   */
      0x1f
        /* "#utility.yul":2895:2902   */
      not
        /* "#utility.yul":2890:2892   */
      0x1f
        /* "#utility.yul":2883:2888   */
      dup4
        /* "#utility.yul":2879:2893   */
      add
        /* "#utility.yul":2875:2903   */
      and
        /* "#utility.yul":2865:2903   */
      swap1
      pop
        /* "#utility.yul":2807:2909   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":2915:3095   */
    tag_93:
        /* "#utility.yul":2963:3040   */
      0x4e487b7100000000000000000000000000000000000000000000000000000000
        /* "#utility.yul":2960:2961   */
      0x00
        /* "#utility.yul":2953:3041   */
      mstore
        /* "#utility.yul":3060:3064   */
      0x41
        /* "#utility.yul":3057:3058   */
      0x04
        /* "#utility.yul":3050:3065   */
      mstore
        /* "#utility.yul":3084:3088   */
      0x24
        /* "#utility.yul":3081:3082   */
      0x00
        /* "#utility.yul":3074:3089   */
      revert
        /* "#utility.yul":3101:3382   */
    tag_94:
        /* "#utility.yul":3184:3211   */
      tag_171
        /* "#utility.yul":3206:3210   */
      dup3
        /* "#utility.yul":3184:3211   */
      tag_92
      jump	// in
    tag_171:
        /* "#utility.yul":3176:3182   */
      dup2
        /* "#utility.yul":3172:3212   */
      add
        /* "#utility.yul":3314:3320   */
      dup2
        /* "#utility.yul":3302:3312   */
      dup2
        /* "#utility.yul":3299:3321   */
      lt
        /* "#utility.yul":3278:3296   */
      0xffffffffffffffff
        /* "#utility.yul":3266:3276   */
      dup3
        /* "#utility.yul":3263:3297   */
      gt
        /* "#utility.yul":3260:3322   */
      or
        /* "#utility.yul":3257:3345   */
      iszero
      tag_172
      jumpi
        /* "#utility.yul":3325:3343   */
      tag_173
      tag_93
      jump	// in
    tag_173:
        /* "#utility.yul":3257:3345   */
    tag_172:
        /* "#utility.yul":3365:3375   */
      dup1
        /* "#utility.yul":3361:3363   */
      0x40
        /* "#utility.yul":3354:3376   */
      mstore
        /* "#utility.yul":3144:3382   */
      pop
        /* "#utility.yul":3101:3382   */
      pop
      pop
      jump	// out
        /* "#utility.yul":3388:3517   */
    tag_95:
        /* "#utility.yul":3422:3428   */
      0x00
        /* "#utility.yul":3449:3469   */
      tag_175
      tag_78
      jump	// in
    tag_175:
        /* "#utility.yul":3439:3469   */
      swap1
      pop
        /* "#utility.yul":3478:3511   */
      tag_176
        /* "#utility.yul":3506:3510   */
      dup3
        /* "#utility.yul":3498:3504   */
      dup3
        /* "#utility.yul":3478:3511   */
      tag_94
      jump	// in
    tag_176:
        /* "#utility.yul":3388:3517   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":3523:3831   */
    tag_96:
        /* "#utility.yul":3585:3589   */
      0x00
        /* "#utility.yul":3675:3693   */
      0xffffffffffffffff
        /* "#utility.yul":3667:3673   */
      dup3
        /* "#utility.yul":3664:3694   */
      gt
        /* "#utility.yul":3661:3717   */
      iszero
      tag_178
      jumpi
        /* "#utility.yul":3697:3715   */
      tag_179
      tag_93
      jump	// in
    tag_179:
        /* "#utility.yul":3661:3717   */
    tag_178:
        /* "#utility.yul":3735:3764   */
      tag_180
        /* "#utility.yul":3757:3763   */
      dup3
        /* "#utility.yul":3735:3764   */
      tag_92
      jump	// in
    tag_180:
        /* "#utility.yul":3727:3764   */
      swap1
      pop
        /* "#utility.yul":3819:3823   */
      0x20
        /* "#utility.yul":3813:3817   */
      dup2
        /* "#utility.yul":3809:3824   */
      add
        /* "#utility.yul":3801:3824   */
      swap1
      pop
        /* "#utility.yul":3523:3831   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":3837:3983   */
    tag_97:
        /* "#utility.yul":3934:3940   */
      dup3
        /* "#utility.yul":3929:3932   */
      dup2
        /* "#utility.yul":3924:3927   */
      dup4
        /* "#utility.yul":3911:3941   */
      calldatacopy
        /* "#utility.yul":3975:3976   */
      0x00
        /* "#utility.yul":3966:3972   */
      dup4
        /* "#utility.yul":3961:3964   */
      dup4
        /* "#utility.yul":3957:3973   */
      add
        /* "#utility.yul":3950:3977   */
      mstore
        /* "#utility.yul":3837:3983   */
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":3989:4414   */
    tag_98:
        /* "#utility.yul":4067:4072   */
      0x00
        /* "#utility.yul":4092:4158   */
      tag_183
        /* "#utility.yul":4108:4157   */
      tag_184
        /* "#utility.yul":4150:4156   */
      dup5
        /* "#utility.yul":4108:4157   */
      tag_96
      jump	// in
    tag_184:
        /* "#utility.yul":4092:4158   */
      tag_95
      jump	// in
    tag_183:
        /* "#utility.yul":4083:4158   */
      swap1
      pop
        /* "#utility.yul":4181:4187   */
      dup3
        /* "#utility.yul":4174:4179   */
      dup2
        /* "#utility.yul":4167:4188   */
      mstore
        /* "#utility.yul":4219:4223   */
      0x20
        /* "#utility.yul":4212:4217   */
      dup2
        /* "#utility.yul":4208:4224   */
      add
        /* "#utility.yul":4257:4260   */
      dup5
        /* "#utility.yul":4248:4254   */
      dup5
        /* "#utility.yul":4243:4246   */
      dup5
        /* "#utility.yul":4239:4255   */
      add
        /* "#utility.yul":4236:4261   */
      gt
        /* "#utility.yul":4233:4345   */
      iszero
      tag_185
      jumpi
        /* "#utility.yul":4264:4343   */
      tag_186
      tag_91
      jump	// in
    tag_186:
        /* "#utility.yul":4233:4345   */
    tag_185:
        /* "#utility.yul":4354:4408   */
      tag_187
        /* "#utility.yul":4401:4407   */
      dup5
        /* "#utility.yul":4396:4399   */
      dup3
        /* "#utility.yul":4391:4394   */
      dup6
        /* "#utility.yul":4354:4408   */
      tag_97
      jump	// in
    tag_187:
        /* "#utility.yul":4073:4414   */
      pop
        /* "#utility.yul":3989:4414   */
      swap4
      swap3
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":4434:4774   */
    tag_99:
        /* "#utility.yul":4490:4495   */
      0x00
        /* "#utility.yul":4539:4542   */
      dup3
        /* "#utility.yul":4532:4536   */
      0x1f
        /* "#utility.yul":4524:4530   */
      dup4
        /* "#utility.yul":4520:4537   */
      add
        /* "#utility.yul":4516:4543   */
      slt
        /* "#utility.yul":4506:4628   */
      tag_189
      jumpi
        /* "#utility.yul":4547:4626   */
      tag_190
      tag_90
      jump	// in
    tag_190:
        /* "#utility.yul":4506:4628   */
    tag_189:
        /* "#utility.yul":4664:4670   */
      dup2
        /* "#utility.yul":4651:4671   */
      calldataload
        /* "#utility.yul":4689:4768   */
      tag_191
        /* "#utility.yul":4764:4767   */
      dup5
        /* "#utility.yul":4756:4762   */
      dup3
        /* "#utility.yul":4749:4753   */
      0x20
        /* "#utility.yul":4741:4747   */
      dup7
        /* "#utility.yul":4737:4754   */
      add
        /* "#utility.yul":4689:4768   */
      tag_98
      jump	// in
    tag_191:
        /* "#utility.yul":4680:4768   */
      swap2
      pop
        /* "#utility.yul":4496:4774   */
      pop
        /* "#utility.yul":4434:4774   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":4780:5289   */
    tag_28:
        /* "#utility.yul":4849:4855   */
      0x00
        /* "#utility.yul":4898:4900   */
      0x20
        /* "#utility.yul":4886:4895   */
      dup3
        /* "#utility.yul":4877:4884   */
      dup5
        /* "#utility.yul":4873:4896   */
      sub
        /* "#utility.yul":4869:4901   */
      slt
        /* "#utility.yul":4866:4985   */
      iszero
      tag_193
      jumpi
        /* "#utility.yul":4904:4983   */
      tag_194
      tag_79
      jump	// in
    tag_194:
        /* "#utility.yul":4866:4985   */
    tag_193:
        /* "#utility.yul":5052:5053   */
      0x00
        /* "#utility.yul":5041:5050   */
      dup3
        /* "#utility.yul":5037:5054   */
      add
        /* "#utility.yul":5024:5055   */
      calldataload
        /* "#utility.yul":5082:5100   */
      0xffffffffffffffff
        /* "#utility.yul":5074:5080   */
      dup2
        /* "#utility.yul":5071:5101   */
      gt
        /* "#utility.yul":5068:5185   */
      iszero
      tag_195
      jumpi
        /* "#utility.yul":5104:5183   */
      tag_196
      tag_80
      jump	// in
    tag_196:
        /* "#utility.yul":5068:5185   */
    tag_195:
        /* "#utility.yul":5209:5272   */
      tag_197
        /* "#utility.yul":5264:5271   */
      dup5
        /* "#utility.yul":5255:5261   */
      dup3
        /* "#utility.yul":5244:5253   */
      dup6
        /* "#utility.yul":5240:5262   */
      add
        /* "#utility.yul":5209:5272   */
      tag_99
      jump	// in
    tag_197:
        /* "#utility.yul":5199:5272   */
      swap2
      pop
        /* "#utility.yul":4995:5282   */
      pop
        /* "#utility.yul":4780:5289   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":5295:5394   */
    tag_100:
        /* "#utility.yul":5347:5353   */
      0x00
        /* "#utility.yul":5381:5386   */
      dup2
        /* "#utility.yul":5375:5387   */
      mload
        /* "#utility.yul":5365:5387   */
      swap1
      pop
        /* "#utility.yul":5295:5394   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":5400:5569   */
    tag_101:
        /* "#utility.yul":5484:5495   */
      0x00
        /* "#utility.yul":5518:5524   */
      dup3
        /* "#utility.yul":5513:5516   */
      dup3
        /* "#utility.yul":5506:5525   */
      mstore
        /* "#utility.yul":5558:5562   */
      0x20
        /* "#utility.yul":5553:5556   */
      dup3
        /* "#utility.yul":5549:5563   */
      add
        /* "#utility.yul":5534:5563   */
      swap1
      pop
        /* "#utility.yul":5400:5569   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":5575:5821   */
    tag_102:
        /* "#utility.yul":5656:5657   */
      0x00
        /* "#utility.yul":5666:5779   */
    tag_201:
        /* "#utility.yul":5680:5686   */
      dup4
        /* "#utility.yul":5677:5678   */
      dup2
        /* "#utility.yul":5674:5687   */
      lt
        /* "#utility.yul":5666:5779   */
      iszero
      tag_203
      jumpi
        /* "#utility.yul":5765:5766   */
      dup1
        /* "#utility.yul":5760:5763   */
      dup3
        /* "#utility.yul":5756:5767   */
      add
        /* "#utility.yul":5750:5768   */
      mload
        /* "#utility.yul":5746:5747   */
      dup2
        /* "#utility.yul":5741:5744   */
      dup5
        /* "#utility.yul":5737:5748   */
      add
        /* "#utility.yul":5730:5769   */
      mstore
        /* "#utility.yul":5702:5704   */
      0x20
        /* "#utility.yul":5699:5700   */
      dup2
        /* "#utility.yul":5695:5705   */
      add
        /* "#utility.yul":5690:5705   */
      swap1
      pop
        /* "#utility.yul":5666:5779   */
      jump(tag_201)
    tag_203:
        /* "#utility.yul":5813:5814   */
      0x00
        /* "#utility.yul":5804:5810   */
      dup5
        /* "#utility.yul":5799:5802   */
      dup5
        /* "#utility.yul":5795:5811   */
      add
        /* "#utility.yul":5788:5815   */
      mstore
        /* "#utility.yul":5637:5821   */
      pop
        /* "#utility.yul":5575:5821   */
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":5827:6204   */
    tag_103:
        /* "#utility.yul":5915:5918   */
      0x00
        /* "#utility.yul":5943:5982   */
      tag_205
        /* "#utility.yul":5976:5981   */
      dup3
        /* "#utility.yul":5943:5982   */
      tag_100
      jump	// in
    tag_205:
        /* "#utility.yul":5998:6069   */
      tag_206
        /* "#utility.yul":6062:6068   */
      dup2
        /* "#utility.yul":6057:6060   */
      dup6
        /* "#utility.yul":5998:6069   */
      tag_101
      jump	// in
    tag_206:
        /* "#utility.yul":5991:6069   */
      swap4
      pop
        /* "#utility.yul":6078:6143   */
      tag_207
        /* "#utility.yul":6136:6142   */
      dup2
        /* "#utility.yul":6131:6134   */
      dup6
        /* "#utility.yul":6124:6128   */
      0x20
        /* "#utility.yul":6117:6122   */
      dup7
        /* "#utility.yul":6113:6129   */
      add
        /* "#utility.yul":6078:6143   */
      tag_102
      jump	// in
    tag_207:
        /* "#utility.yul":6168:6197   */
      tag_208
        /* "#utility.yul":6190:6196   */
      dup2
        /* "#utility.yul":6168:6197   */
      tag_92
      jump	// in
    tag_208:
        /* "#utility.yul":6163:6166   */
      dup5
        /* "#utility.yul":6159:6198   */
      add
        /* "#utility.yul":6152:6198   */
      swap2
      pop
        /* "#utility.yul":5919:6204   */
      pop
        /* "#utility.yul":5827:6204   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":6210:6523   */
    tag_33:
        /* "#utility.yul":6323:6327   */
      0x00
        /* "#utility.yul":6361:6363   */
      0x20
        /* "#utility.yul":6350:6359   */
      dup3
        /* "#utility.yul":6346:6364   */
      add
        /* "#utility.yul":6338:6364   */
      swap1
      pop
        /* "#utility.yul":6410:6419   */
      dup2
        /* "#utility.yul":6404:6408   */
      dup2
        /* "#utility.yul":6400:6420   */
      sub
        /* "#utility.yul":6396:6397   */
      0x00
        /* "#utility.yul":6385:6394   */
      dup4
        /* "#utility.yul":6381:6398   */
      add
        /* "#utility.yul":6374:6421   */
      mstore
        /* "#utility.yul":6438:6516   */
      tag_210
        /* "#utility.yul":6511:6515   */
      dup2
        /* "#utility.yul":6502:6508   */
      dup5
        /* "#utility.yul":6438:6516   */
      tag_103
      jump	// in
    tag_210:
        /* "#utility.yul":6430:6516   */
      swap1
      pop
        /* "#utility.yul":6210:6523   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":6529:6655   */
    tag_104:
        /* "#utility.yul":6566:6573   */
      0x00
        /* "#utility.yul":6606:6648   */
      0xffffffffffffffffffffffffffffffffffffffff
        /* "#utility.yul":6599:6604   */
      dup3
        /* "#utility.yul":6595:6649   */
      and
        /* "#utility.yul":6584:6649   */
      swap1
      pop
        /* "#utility.yul":6529:6655   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":6661:6757   */
    tag_105:
        /* "#utility.yul":6698:6705   */
      0x00
        /* "#utility.yul":6727:6751   */
      tag_213
        /* "#utility.yul":6745:6750   */
      dup3
        /* "#utility.yul":6727:6751   */
      tag_104
      jump	// in
    tag_213:
        /* "#utility.yul":6716:6751   */
      swap1
      pop
        /* "#utility.yul":6661:6757   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":6763:6885   */
    tag_106:
        /* "#utility.yul":6836:6860   */
      tag_215
        /* "#utility.yul":6854:6859   */
      dup2
        /* "#utility.yul":6836:6860   */
      tag_105
      jump	// in
    tag_215:
        /* "#utility.yul":6829:6834   */
      dup2
        /* "#utility.yul":6826:6861   */
      eq
        /* "#utility.yul":6816:6879   */
      tag_216
      jumpi
        /* "#utility.yul":6875:6876   */
      0x00
        /* "#utility.yul":6872:6873   */
      dup1
        /* "#utility.yul":6865:6877   */
      revert
        /* "#utility.yul":6816:6879   */
    tag_216:
        /* "#utility.yul":6763:6885   */
      pop
      jump	// out
        /* "#utility.yul":6891:7030   */
    tag_107:
        /* "#utility.yul":6937:6942   */
      0x00
        /* "#utility.yul":6975:6981   */
      dup2
        /* "#utility.yul":6962:6982   */
      calldataload
        /* "#utility.yul":6953:6982   */
      swap1
      pop
        /* "#utility.yul":6991:7024   */
      tag_218
        /* "#utility.yul":7018:7023   */
      dup2
        /* "#utility.yul":6991:7024   */
      tag_106
      jump	// in
    tag_218:
        /* "#utility.yul":6891:7030   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":7036:7365   */
    tag_36:
        /* "#utility.yul":7095:7101   */
      0x00
        /* "#utility.yul":7144:7146   */
      0x20
        /* "#utility.yul":7132:7141   */
      dup3
        /* "#utility.yul":7123:7130   */
      dup5
        /* "#utility.yul":7119:7142   */
      sub
        /* "#utility.yul":7115:7147   */
      slt
        /* "#utility.yul":7112:7231   */
      iszero
      tag_220
      jumpi
        /* "#utility.yul":7150:7229   */
      tag_221
      tag_79
      jump	// in
    tag_221:
        /* "#utility.yul":7112:7231   */
    tag_220:
        /* "#utility.yul":7270:7271   */
      0x00
        /* "#utility.yul":7295:7348   */
      tag_222
        /* "#utility.yul":7340:7347   */
      dup5
        /* "#utility.yul":7331:7337   */
      dup3
        /* "#utility.yul":7320:7329   */
      dup6
        /* "#utility.yul":7316:7338   */
      add
        /* "#utility.yul":7295:7348   */
      tag_107
      jump	// in
    tag_222:
        /* "#utility.yul":7285:7348   */
      swap2
      pop
        /* "#utility.yul":7241:7358   */
      pop
        /* "#utility.yul":7036:7365   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":7371:7479   */
    tag_108:
        /* "#utility.yul":7448:7472   */
      tag_224
        /* "#utility.yul":7466:7471   */
      dup2
        /* "#utility.yul":7448:7472   */
      tag_81
      jump	// in
    tag_224:
        /* "#utility.yul":7443:7446   */
      dup3
        /* "#utility.yul":7436:7473   */
      mstore
        /* "#utility.yul":7371:7479   */
      pop
      pop
      jump	// out
        /* "#utility.yul":7485:7644   */
    tag_109:
        /* "#utility.yul":7559:7570   */
      0x00
        /* "#utility.yul":7593:7599   */
      dup3
        /* "#utility.yul":7588:7591   */
      dup3
        /* "#utility.yul":7581:7600   */
      mstore
        /* "#utility.yul":7633:7637   */
      0x20
        /* "#utility.yul":7628:7631   */
      dup3
        /* "#utility.yul":7624:7638   */
      add
        /* "#utility.yul":7609:7638   */
      swap1
      pop
        /* "#utility.yul":7485:7644   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":7650:8007   */
    tag_110:
        /* "#utility.yul":7728:7731   */
      0x00
        /* "#utility.yul":7756:7795   */
      tag_227
        /* "#utility.yul":7789:7794   */
      dup3
        /* "#utility.yul":7756:7795   */
      tag_100
      jump	// in
    tag_227:
        /* "#utility.yul":7811:7872   */
      tag_228
        /* "#utility.yul":7865:7871   */
      dup2
        /* "#utility.yul":7860:7863   */
      dup6
        /* "#utility.yul":7811:7872   */
      tag_109
      jump	// in
    tag_228:
        /* "#utility.yul":7804:7872   */
      swap4
      pop
        /* "#utility.yul":7881:7946   */
      tag_229
        /* "#utility.yul":7939:7945   */
      dup2
        /* "#utility.yul":7934:7937   */
      dup6
        /* "#utility.yul":7927:7931   */
      0x20
        /* "#utility.yul":7920:7925   */
      dup7
        /* "#utility.yul":7916:7932   */
      add
        /* "#utility.yul":7881:7946   */
      tag_102
      jump	// in
    tag_229:
        /* "#utility.yul":7971:8000   */
      tag_230
        /* "#utility.yul":7993:7999   */
      dup2
        /* "#utility.yul":7971:8000   */
      tag_92
      jump	// in
    tag_230:
        /* "#utility.yul":7966:7969   */
      dup5
        /* "#utility.yul":7962:8001   */
      add
        /* "#utility.yul":7955:8001   */
      swap2
      pop
        /* "#utility.yul":7732:8007   */
      pop
        /* "#utility.yul":7650:8007   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":8063:8838   */
    tag_111:
        /* "#utility.yul":8178:8181   */
      0x00
        /* "#utility.yul":8214:8218   */
      0x60
        /* "#utility.yul":8209:8212   */
      dup4
        /* "#utility.yul":8205:8219   */
      add
        /* "#utility.yul":8299:8303   */
      0x00
        /* "#utility.yul":8292:8297   */
      dup4
        /* "#utility.yul":8288:8304   */
      add
        /* "#utility.yul":8282:8305   */
      mload
        /* "#utility.yul":8318:8381   */
      tag_232
        /* "#utility.yul":8375:8379   */
      0x00
        /* "#utility.yul":8370:8373   */
      dup7
        /* "#utility.yul":8366:8380   */
      add
        /* "#utility.yul":8352:8364   */
      dup3
        /* "#utility.yul":8318:8381   */
      tag_108
      jump	// in
    tag_232:
        /* "#utility.yul":8229:8391   */
      pop
        /* "#utility.yul":8473:8477   */
      0x20
        /* "#utility.yul":8466:8471   */
      dup4
        /* "#utility.yul":8462:8478   */
      add
        /* "#utility.yul":8456:8479   */
      mload
        /* "#utility.yul":8526:8529   */
      dup5
        /* "#utility.yul":8520:8524   */
      dup3
        /* "#utility.yul":8516:8530   */
      sub
        /* "#utility.yul":8509:8513   */
      0x20
        /* "#utility.yul":8504:8507   */
      dup7
        /* "#utility.yul":8500:8514   */
      add
        /* "#utility.yul":8493:8531   */
      mstore
        /* "#utility.yul":8552:8625   */
      tag_233
        /* "#utility.yul":8620:8624   */
      dup3
        /* "#utility.yul":8606:8618   */
      dup3
        /* "#utility.yul":8552:8625   */
      tag_110
      jump	// in
    tag_233:
        /* "#utility.yul":8544:8625   */
      swap2
      pop
        /* "#utility.yul":8401:8636   */
      pop
        /* "#utility.yul":8719:8723   */
      0x40
        /* "#utility.yul":8712:8717   */
      dup4
        /* "#utility.yul":8708:8724   */
      add
        /* "#utility.yul":8702:8725   */
      mload
        /* "#utility.yul":8738:8801   */
      tag_234
        /* "#utility.yul":8795:8799   */
      0x40
        /* "#utility.yul":8790:8793   */
      dup7
        /* "#utility.yul":8786:8800   */
      add
        /* "#utility.yul":8772:8784   */
      dup3
        /* "#utility.yul":8738:8801   */
      tag_108
      jump	// in
    tag_234:
        /* "#utility.yul":8646:8811   */
      pop
        /* "#utility.yul":8828:8832   */
      dup1
        /* "#utility.yul":8821:8832   */
      swap2
      pop
        /* "#utility.yul":8183:8838   */
      pop
        /* "#utility.yul":8063:8838   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":8844:9209   */
    tag_46:
        /* "#utility.yul":8983:8987   */
      0x00
        /* "#utility.yul":9021:9023   */
      0x20
        /* "#utility.yul":9010:9019   */
      dup3
        /* "#utility.yul":9006:9024   */
      add
        /* "#utility.yul":8998:9024   */
      swap1
      pop
        /* "#utility.yul":9070:9079   */
      dup2
        /* "#utility.yul":9064:9068   */
      dup2
        /* "#utility.yul":9060:9080   */
      sub
        /* "#utility.yul":9056:9057   */
      0x00
        /* "#utility.yul":9045:9054   */
      dup4
        /* "#utility.yul":9041:9058   */
      add
        /* "#utility.yul":9034:9081   */
      mstore
        /* "#utility.yul":9098:9202   */
      tag_236
        /* "#utility.yul":9197:9201   */
      dup2
        /* "#utility.yul":9188:9194   */
      dup5
        /* "#utility.yul":9098:9202   */
      tag_111
      jump	// in
    tag_236:
        /* "#utility.yul":9090:9202   */
      swap1
      pop
        /* "#utility.yul":8844:9209   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":9215:9389   */
    tag_112:
        /* "#utility.yul":9355:9381   */
      0x73656e6465722068617320616c726561647920766f7465640000000000000000
        /* "#utility.yul":9351:9352   */
      0x00
        /* "#utility.yul":9343:9349   */
      dup3
        /* "#utility.yul":9339:9353   */
      add
        /* "#utility.yul":9332:9382   */
      mstore
        /* "#utility.yul":9215:9389   */
      pop
      jump	// out
        /* "#utility.yul":9395:9761   */
    tag_113:
        /* "#utility.yul":9537:9540   */
      0x00
        /* "#utility.yul":9558:9625   */
      tag_239
        /* "#utility.yul":9622:9624   */
      0x18
        /* "#utility.yul":9617:9620   */
      dup4
        /* "#utility.yul":9558:9625   */
      tag_101
      jump	// in
    tag_239:
        /* "#utility.yul":9551:9625   */
      swap2
      pop
        /* "#utility.yul":9634:9727   */
      tag_240
        /* "#utility.yul":9723:9726   */
      dup3
        /* "#utility.yul":9634:9727   */
      tag_112
      jump	// in
    tag_240:
        /* "#utility.yul":9752:9754   */
      0x20
        /* "#utility.yul":9747:9750   */
      dup3
        /* "#utility.yul":9743:9755   */
      add
        /* "#utility.yul":9736:9755   */
      swap1
      pop
        /* "#utility.yul":9395:9761   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":9767:10186   */
    tag_50:
        /* "#utility.yul":9933:9937   */
      0x00
        /* "#utility.yul":9971:9973   */
      0x20
        /* "#utility.yul":9960:9969   */
      dup3
        /* "#utility.yul":9956:9974   */
      add
        /* "#utility.yul":9948:9974   */
      swap1
      pop
        /* "#utility.yul":10020:10029   */
      dup2
        /* "#utility.yul":10014:10018   */
      dup2
        /* "#utility.yul":10010:10030   */
      sub
        /* "#utility.yul":10006:10007   */
      0x00
        /* "#utility.yul":9995:10004   */
      dup4
        /* "#utility.yul":9991:10008   */
      add
        /* "#utility.yul":9984:10031   */
      mstore
        /* "#utility.yul":10048:10179   */
      tag_242
        /* "#utility.yul":10174:10178   */
      dup2
        /* "#utility.yul":10048:10179   */
      tag_113
      jump	// in
    tag_242:
        /* "#utility.yul":10040:10179   */
      swap1
      pop
        /* "#utility.yul":9767:10186   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":10192:10364   */
    tag_114:
        /* "#utility.yul":10332:10356   */
      0x696e76616c696420766f74652073656c656374696f6e00000000000000000000
        /* "#utility.yul":10328:10329   */
      0x00
        /* "#utility.yul":10320:10326   */
      dup3
        /* "#utility.yul":10316:10330   */
      add
        /* "#utility.yul":10309:10357   */
      mstore
        /* "#utility.yul":10192:10364   */
      pop
      jump	// out
        /* "#utility.yul":10370:10736   */
    tag_115:
        /* "#utility.yul":10512:10515   */
      0x00
        /* "#utility.yul":10533:10600   */
      tag_245
        /* "#utility.yul":10597:10599   */
      0x16
        /* "#utility.yul":10592:10595   */
      dup4
        /* "#utility.yul":10533:10600   */
      tag_101
      jump	// in
    tag_245:
        /* "#utility.yul":10526:10600   */
      swap2
      pop
        /* "#utility.yul":10609:10702   */
      tag_246
        /* "#utility.yul":10698:10701   */
      dup3
        /* "#utility.yul":10609:10702   */
      tag_114
      jump	// in
    tag_246:
        /* "#utility.yul":10727:10729   */
      0x20
        /* "#utility.yul":10722:10725   */
      dup3
        /* "#utility.yul":10718:10730   */
      add
        /* "#utility.yul":10711:10730   */
      swap1
      pop
        /* "#utility.yul":10370:10736   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":10742:11161   */
    tag_54:
        /* "#utility.yul":10908:10912   */
      0x00
        /* "#utility.yul":10946:10948   */
      0x20
        /* "#utility.yul":10935:10944   */
      dup3
        /* "#utility.yul":10931:10949   */
      add
        /* "#utility.yul":10923:10949   */
      swap1
      pop
        /* "#utility.yul":10995:11004   */
      dup2
        /* "#utility.yul":10989:10993   */
      dup2
        /* "#utility.yul":10985:11005   */
      sub
        /* "#utility.yul":10981:10982   */
      0x00
        /* "#utility.yul":10970:10979   */
      dup4
        /* "#utility.yul":10966:10983   */
      add
        /* "#utility.yul":10959:11006   */
      mstore
        /* "#utility.yul":11023:11154   */
      tag_248
        /* "#utility.yul":11149:11153   */
      dup2
        /* "#utility.yul":11023:11154   */
      tag_115
      jump	// in
    tag_248:
        /* "#utility.yul":11015:11154   */
      swap1
      pop
        /* "#utility.yul":10742:11161   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":11167:11347   */
    tag_116:
        /* "#utility.yul":11215:11292   */
      0x4e487b7100000000000000000000000000000000000000000000000000000000
        /* "#utility.yul":11212:11213   */
      0x00
        /* "#utility.yul":11205:11293   */
      mstore
        /* "#utility.yul":11312:11316   */
      0x11
        /* "#utility.yul":11309:11310   */
      0x04
        /* "#utility.yul":11302:11317   */
      mstore
        /* "#utility.yul":11336:11340   */
      0x24
        /* "#utility.yul":11333:11334   */
      0x00
        /* "#utility.yul":11326:11341   */
      revert
        /* "#utility.yul":11353:11586   */
    tag_56:
        /* "#utility.yul":11392:11395   */
      0x00
        /* "#utility.yul":11415:11439   */
      tag_251
        /* "#utility.yul":11433:11438   */
      dup3
        /* "#utility.yul":11415:11439   */
      tag_81
      jump	// in
    tag_251:
        /* "#utility.yul":11406:11439   */
      swap2
      pop
        /* "#utility.yul":11461:11527   */
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        /* "#utility.yul":11454:11459   */
      dup3
        /* "#utility.yul":11451:11528   */
      sub
        /* "#utility.yul":11448:11551   */
      tag_252
      jumpi
        /* "#utility.yul":11531:11549   */
      tag_253
      tag_116
      jump	// in
    tag_253:
        /* "#utility.yul":11448:11551   */
    tag_252:
        /* "#utility.yul":11578:11579   */
      0x01
        /* "#utility.yul":11571:11576   */
      dup3
        /* "#utility.yul":11567:11580   */
      add
        /* "#utility.yul":11560:11580   */
      swap1
      pop
        /* "#utility.yul":11353:11586   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":11592:11772   */
    tag_117:
        /* "#utility.yul":11640:11717   */
      0x4e487b7100000000000000000000000000000000000000000000000000000000
        /* "#utility.yul":11637:11638   */
      0x00
        /* "#utility.yul":11630:11718   */
      mstore
        /* "#utility.yul":11737:11741   */
      0x22
        /* "#utility.yul":11734:11735   */
      0x04
        /* "#utility.yul":11727:11742   */
      mstore
        /* "#utility.yul":11761:11765   */
      0x24
        /* "#utility.yul":11758:11759   */
      0x00
        /* "#utility.yul":11751:11766   */
      revert
        /* "#utility.yul":11778:12098   */
    tag_65:
        /* "#utility.yul":11822:11828   */
      0x00
        /* "#utility.yul":11859:11860   */
      0x02
        /* "#utility.yul":11853:11857   */
      dup3
        /* "#utility.yul":11849:11861   */
      div
        /* "#utility.yul":11839:11861   */
      swap1
      pop
        /* "#utility.yul":11906:11907   */
      0x01
        /* "#utility.yul":11900:11904   */
      dup3
        /* "#utility.yul":11896:11908   */
      and
        /* "#utility.yul":11927:11945   */
      dup1
        /* "#utility.yul":11917:11998   */
      tag_256
      jumpi
        /* "#utility.yul":11983:11987   */
      0x7f
        /* "#utility.yul":11975:11981   */
      dup3
        /* "#utility.yul":11971:11988   */
      and
        /* "#utility.yul":11961:11988   */
      swap2
      pop
        /* "#utility.yul":11917:11998   */
    tag_256:
        /* "#utility.yul":12045:12047   */
      0x20
        /* "#utility.yul":12037:12043   */
      dup3
        /* "#utility.yul":12034:12048   */
      lt
        /* "#utility.yul":12014:12032   */
      dup2
        /* "#utility.yul":12011:12049   */
      sub
        /* "#utility.yul":12008:12092   */
      tag_257
      jumpi
        /* "#utility.yul":12064:12082   */
      tag_258
      tag_117
      jump	// in
    tag_258:
        /* "#utility.yul":12008:12092   */
    tag_257:
        /* "#utility.yul":11829:12098   */
      pop
        /* "#utility.yul":11778:12098   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":12104:12245   */
    tag_118:
        /* "#utility.yul":12153:12157   */
      0x00
        /* "#utility.yul":12176:12179   */
      dup2
        /* "#utility.yul":12168:12179   */
      swap1
      pop
        /* "#utility.yul":12199:12202   */
      dup2
        /* "#utility.yul":12196:12197   */
      0x00
        /* "#utility.yul":12189:12203   */
      mstore
        /* "#utility.yul":12233:12237   */
      0x20
        /* "#utility.yul":12230:12231   */
      0x00
        /* "#utility.yul":12220:12238   */
      keccak256
        /* "#utility.yul":12212:12238   */
      swap1
      pop
        /* "#utility.yul":12104:12245   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":12251:12344   */
    tag_119:
        /* "#utility.yul":12288:12294   */
      0x00
        /* "#utility.yul":12335:12337   */
      0x20
        /* "#utility.yul":12330:12332   */
      0x1f
        /* "#utility.yul":12323:12328   */
      dup4
        /* "#utility.yul":12319:12333   */
      add
        /* "#utility.yul":12315:12338   */
      div
        /* "#utility.yul":12305:12338   */
      swap1
      pop
        /* "#utility.yul":12251:12344   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":12350:12457   */
    tag_120:
        /* "#utility.yul":12394:12402   */
      0x00
        /* "#utility.yul":12444:12449   */
      dup3
        /* "#utility.yul":12438:12442   */
      dup3
        /* "#utility.yul":12434:12450   */
      shl
        /* "#utility.yul":12413:12450   */
      swap1
      pop
        /* "#utility.yul":12350:12457   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":12463:12856   */
    tag_121:
        /* "#utility.yul":12532:12538   */
      0x00
        /* "#utility.yul":12582:12583   */
      0x08
        /* "#utility.yul":12570:12580   */
      dup4
        /* "#utility.yul":12566:12584   */
      mul
        /* "#utility.yul":12605:12702   */
      tag_263
        /* "#utility.yul":12635:12701   */
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        /* "#utility.yul":12624:12633   */
      dup3
        /* "#utility.yul":12605:12702   */
      tag_120
      jump	// in
    tag_263:
        /* "#utility.yul":12723:12762   */
      tag_264
        /* "#utility.yul":12753:12761   */
      dup7
        /* "#utility.yul":12742:12751   */
      dup4
        /* "#utility.yul":12723:12762   */
      tag_120
      jump	// in
    tag_264:
        /* "#utility.yul":12711:12762   */
      swap6
      pop
        /* "#utility.yul":12795:12799   */
      dup1
        /* "#utility.yul":12791:12800   */
      not
        /* "#utility.yul":12784:12789   */
      dup5
        /* "#utility.yul":12780:12801   */
      and
        /* "#utility.yul":12771:12801   */
      swap4
      pop
        /* "#utility.yul":12844:12848   */
      dup1
        /* "#utility.yul":12834:12842   */
      dup7
        /* "#utility.yul":12830:12849   */
      and
        /* "#utility.yul":12823:12828   */
      dup5
        /* "#utility.yul":12820:12850   */
      or
        /* "#utility.yul":12810:12850   */
      swap3
      pop
        /* "#utility.yul":12539:12856   */
      pop
      pop
        /* "#utility.yul":12463:12856   */
      swap4
      swap3
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":12862:12922   */
    tag_122:
        /* "#utility.yul":12890:12893   */
      0x00
        /* "#utility.yul":12911:12916   */
      dup2
        /* "#utility.yul":12904:12916   */
      swap1
      pop
        /* "#utility.yul":12862:12922   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":12928:13070   */
    tag_123:
        /* "#utility.yul":12978:12987   */
      0x00
        /* "#utility.yul":13011:13064   */
      tag_267
        /* "#utility.yul":13029:13063   */
      tag_268
        /* "#utility.yul":13038:13062   */
      tag_269
        /* "#utility.yul":13056:13061   */
      dup5
        /* "#utility.yul":13038:13062   */
      tag_81
      jump	// in
    tag_269:
        /* "#utility.yul":13029:13063   */
      tag_122
      jump	// in
    tag_268:
        /* "#utility.yul":13011:13064   */
      tag_81
      jump	// in
    tag_267:
        /* "#utility.yul":12998:13064   */
      swap1
      pop
        /* "#utility.yul":12928:13070   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":13076:13151   */
    tag_124:
        /* "#utility.yul":13119:13122   */
      0x00
        /* "#utility.yul":13140:13145   */
      dup2
        /* "#utility.yul":13133:13145   */
      swap1
      pop
        /* "#utility.yul":13076:13151   */
      swap2
      swap1
      pop
      jump	// out
        /* "#utility.yul":13157:13426   */
    tag_125:
        /* "#utility.yul":13267:13306   */
      tag_272
        /* "#utility.yul":13298:13305   */
      dup4
        /* "#utility.yul":13267:13306   */
      tag_123
      jump	// in
    tag_272:
        /* "#utility.yul":13328:13419   */
      tag_273
        /* "#utility.yul":13377:13418   */
      tag_274
        /* "#utility.yul":13401:13417   */
      dup3
        /* "#utility.yul":13377:13418   */
      tag_124
      jump	// in
    tag_274:
        /* "#utility.yul":13369:13375   */
      dup5
        /* "#utility.yul":13362:13366   */
      dup5
        /* "#utility.yul":13356:13367   */
      sload
        /* "#utility.yul":13328:13419   */
      tag_121
      jump	// in
    tag_273:
        /* "#utility.yul":13322:13326   */
      dup3
        /* "#utility.yul":13315:13420   */
      sstore
        /* "#utility.yul":13233:13426   */
      pop
        /* "#utility.yul":13157:13426   */
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":13432:13505   */
    tag_126:
        /* "#utility.yul":13477:13480   */
      0x00
        /* "#utility.yul":13432:13505   */
      swap1
      jump	// out
        /* "#utility.yul":13511:13700   */
    tag_127:
        /* "#utility.yul":13588:13620   */
      tag_277
      tag_126
      jump	// in
    tag_277:
        /* "#utility.yul":13629:13694   */
      tag_278
        /* "#utility.yul":13687:13693   */
      dup2
        /* "#utility.yul":13679:13685   */
      dup5
        /* "#utility.yul":13673:13677   */
      dup5
        /* "#utility.yul":13629:13694   */
      tag_125
      jump	// in
    tag_278:
        /* "#utility.yul":13564:13700   */
      pop
        /* "#utility.yul":13511:13700   */
      pop
      pop
      jump	// out
        /* "#utility.yul":13706:13892   */
    tag_128:
        /* "#utility.yul":13766:13886   */
    tag_280:
        /* "#utility.yul":13783:13786   */
      dup2
        /* "#utility.yul":13776:13781   */
      dup2
        /* "#utility.yul":13773:13787   */
      lt
        /* "#utility.yul":13766:13886   */
      iszero
      tag_282
      jumpi
        /* "#utility.yul":13837:13876   */
      tag_283
        /* "#utility.yul":13874:13875   */
      0x00
        /* "#utility.yul":13867:13872   */
      dup3
        /* "#utility.yul":13837:13876   */
      tag_127
      jump	// in
    tag_283:
        /* "#utility.yul":13810:13811   */
      0x01
        /* "#utility.yul":13803:13808   */
      dup2
        /* "#utility.yul":13799:13812   */
      add
        /* "#utility.yul":13790:13812   */
      swap1
      pop
        /* "#utility.yul":13766:13886   */
      jump(tag_280)
    tag_282:
        /* "#utility.yul":13706:13892   */
      pop
      pop
      jump	// out
        /* "#utility.yul":13898:14441   */
    tag_129:
        /* "#utility.yul":13999:14001   */
      0x1f
        /* "#utility.yul":13994:13997   */
      dup3
        /* "#utility.yul":13991:14002   */
      gt
        /* "#utility.yul":13988:14434   */
      iszero
      tag_285
      jumpi
        /* "#utility.yul":14033:14071   */
      tag_286
        /* "#utility.yul":14065:14070   */
      dup2
        /* "#utility.yul":14033:14071   */
      tag_118
      jump	// in
    tag_286:
        /* "#utility.yul":14117:14146   */
      tag_287
        /* "#utility.yul":14135:14145   */
      dup5
        /* "#utility.yul":14117:14146   */
      tag_119
      jump	// in
    tag_287:
        /* "#utility.yul":14107:14115   */
      dup2
        /* "#utility.yul":14103:14147   */
      add
        /* "#utility.yul":14300:14302   */
      0x20
        /* "#utility.yul":14288:14298   */
      dup6
        /* "#utility.yul":14285:14303   */
      lt
        /* "#utility.yul":14282:14331   */
      iszero
      tag_288
      jumpi
        /* "#utility.yul":14321:14329   */
      dup2
        /* "#utility.yul":14306:14329   */
      swap1
      pop
        /* "#utility.yul":14282:14331   */
    tag_288:
        /* "#utility.yul":14344:14424   */
      tag_289
        /* "#utility.yul":14400:14422   */
      tag_290
        /* "#utility.yul":14418:14421   */
      dup6
        /* "#utility.yul":14400:14422   */
      tag_119
      jump	// in
    tag_290:
        /* "#utility.yul":14390:14398   */
      dup4
        /* "#utility.yul":14386:14423   */
      add
        /* "#utility.yul":14373:14384   */
      dup3
        /* "#utility.yul":14344:14424   */
      tag_128
      jump	// in
    tag_289:
        /* "#utility.yul":14003:14434   */
      pop
      pop
        /* "#utility.yul":13988:14434   */
    tag_285:
        /* "#utility.yul":13898:14441   */
      pop
      pop
      pop
      jump	// out
        /* "#utility.yul":14447:14564   */
    tag_130:
        /* "#utility.yul":14501:14509   */
      0x00
        /* "#utility.yul":14551:14556   */
      dup3
        /* "#utility.yul":14545:14549   */
      dup3
        /* "#utility.yul":14541:14557   */
      shr
        /* "#utility.yul":14520:14557   */
      swap1
      pop
        /* "#utility.yul":14447:14564   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":14570:14739   */
    tag_131:
        /* "#utility.yul":14614:14620   */
      0x00
        /* "#utility.yul":14647:14698   */
      tag_293
        /* "#utility.yul":14695:14696   */
      0x00
        /* "#utility.yul":14691:14697   */
      not
        /* "#utility.yul":14683:14688   */
      dup5
        /* "#utility.yul":14680:14681   */
      0x08
        /* "#utility.yul":14676:14689   */
      mul
        /* "#utility.yul":14647:14698   */
      tag_130
      jump	// in
    tag_293:
        /* "#utility.yul":14643:14699   */
      not
        /* "#utility.yul":14728:14732   */
      dup1
        /* "#utility.yul":14722:14726   */
      dup4
        /* "#utility.yul":14718:14733   */
      and
        /* "#utility.yul":14708:14733   */
      swap2
      pop
        /* "#utility.yul":14621:14739   */
      pop
        /* "#utility.yul":14570:14739   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":14744:15039   */
    tag_132:
        /* "#utility.yul":14820:14824   */
      0x00
        /* "#utility.yul":14966:14995   */
      tag_295
        /* "#utility.yul":14991:14994   */
      dup4
        /* "#utility.yul":14985:14989   */
      dup4
        /* "#utility.yul":14966:14995   */
      tag_131
      jump	// in
    tag_295:
        /* "#utility.yul":14958:14995   */
      swap2
      pop
        /* "#utility.yul":15028:15031   */
      dup3
        /* "#utility.yul":15025:15026   */
      0x02
        /* "#utility.yul":15021:15032   */
      mul
        /* "#utility.yul":15015:15019   */
      dup3
        /* "#utility.yul":15012:15033   */
      or
        /* "#utility.yul":15004:15033   */
      swap1
      pop
        /* "#utility.yul":14744:15039   */
      swap3
      swap2
      pop
      pop
      jump	// out
        /* "#utility.yul":15044:16439   */
    tag_61:
        /* "#utility.yul":15161:15198   */
      tag_297
        /* "#utility.yul":15194:15197   */
      dup3
        /* "#utility.yul":15161:15198   */
      tag_100
      jump	// in
    tag_297:
        /* "#utility.yul":15263:15281   */
      0xffffffffffffffff
        /* "#utility.yul":15255:15261   */
      dup2
        /* "#utility.yul":15252:15282   */
      gt
        /* "#utility.yul":15249:15305   */
      iszero
      tag_298
      jumpi
        /* "#utility.yul":15285:15303   */
      tag_299
      tag_93
      jump	// in
    tag_299:
        /* "#utility.yul":15249:15305   */
    tag_298:
        /* "#utility.yul":15329:15367   */
      tag_300
        /* "#utility.yul":15361:15365   */
      dup3
        /* "#utility.yul":15355:15366   */
      sload
        /* "#utility.yul":15329:15367   */
      tag_65
      jump	// in
    tag_300:
        /* "#utility.yul":15414:15481   */
      tag_301
        /* "#utility.yul":15474:15480   */
      dup3
        /* "#utility.yul":15466:15472   */
      dup3
        /* "#utility.yul":15460:15464   */
      dup6
        /* "#utility.yul":15414:15481   */
      tag_129
      jump	// in
    tag_301:
        /* "#utility.yul":15508:15509   */
      0x00
        /* "#utility.yul":15532:15536   */
      0x20
        /* "#utility.yul":15519:15536   */
      swap1
      pop
        /* "#utility.yul":15564:15566   */
      0x1f
        /* "#utility.yul":15556:15562   */
      dup4
        /* "#utility.yul":15553:15567   */
      gt
        /* "#utility.yul":15581:15582   */
      0x01
        /* "#utility.yul":15576:16194   */
      dup2
      eq
      tag_303
      jumpi
        /* "#utility.yul":16238:16239   */
      0x00
        /* "#utility.yul":16255:16261   */
      dup5
        /* "#utility.yul":16252:16329   */
      iszero
      tag_304
      jumpi
        /* "#utility.yul":16304:16313   */
      dup3
        /* "#utility.yul":16299:16302   */
      dup8
        /* "#utility.yul":16295:16314   */
      add
        /* "#utility.yul":16289:16315   */
      mload
        /* "#utility.yul":16280:16315   */
      swap1
      pop
        /* "#utility.yul":16252:16329   */
    tag_304:
        /* "#utility.yul":16355:16422   */
      tag_305
        /* "#utility.yul":16415:16421   */
      dup6
        /* "#utility.yul":16408:16413   */
      dup3
        /* "#utility.yul":16355:16422   */
      tag_132
      jump	// in
    tag_305:
        /* "#utility.yul":16349:16353   */
      dup7
        /* "#utility.yul":16342:16423   */
      sstore
        /* "#utility.yul":16211:16433   */
      pop
        /* "#utility.yul":15546:16433   */
      jump(tag_302)
        /* "#utility.yul":15576:16194   */
    tag_303:
        /* "#utility.yul":15628:15632   */
      0x1f
        /* "#utility.yul":15624:15633   */
      not
        /* "#utility.yul":15616:15622   */
      dup5
        /* "#utility.yul":15612:15634   */
      and
        /* "#utility.yul":15662:15699   */
      tag_306
        /* "#utility.yul":15694:15698   */
      dup7
        /* "#utility.yul":15662:15699   */
      tag_118
      jump	// in
    tag_306:
        /* "#utility.yul":15721:15722   */
      0x00
        /* "#utility.yul":15735:15943   */
    tag_307:
        /* "#utility.yul":15749:15756   */
      dup3
        /* "#utility.yul":15746:15747   */
      dup2
        /* "#utility.yul":15743:15757   */
      lt
        /* "#utility.yul":15735:15943   */
      iszero
      tag_309
      jumpi
        /* "#utility.yul":15828:15837   */
      dup5
        /* "#utility.yul":15823:15826   */
      dup10
        /* "#utility.yul":15819:15838   */
      add
        /* "#utility.yul":15813:15839   */
      mload
        /* "#utility.yul":15805:15811   */
      dup3
        /* "#utility.yul":15798:15840   */
      sstore
        /* "#utility.yul":15879:15880   */
      0x01
        /* "#utility.yul":15871:15877   */
      dup3
        /* "#utility.yul":15867:15881   */
      add
        /* "#utility.yul":15857:15881   */
      swap2
      pop
        /* "#utility.yul":15926:15928   */
      0x20
        /* "#utility.yul":15915:15924   */
      dup6
        /* "#utility.yul":15911:15929   */
      add
        /* "#utility.yul":15898:15929   */
      swap5
      pop
        /* "#utility.yul":15772:15776   */
      0x20
        /* "#utility.yul":15769:15770   */
      dup2
        /* "#utility.yul":15765:15777   */
      add
        /* "#utility.yul":15760:15777   */
      swap1
      pop
        /* "#utility.yul":15735:15943   */
      jump(tag_307)
    tag_309:
        /* "#utility.yul":15971:15977   */
      dup7
        /* "#utility.yul":15962:15969   */
      dup4
        /* "#utility.yul":15959:15978   */
      lt
        /* "#utility.yul":15956:16135   */
      iszero
      tag_310
      jumpi
        /* "#utility.yul":16029:16038   */
      dup5
        /* "#utility.yul":16024:16027   */
      dup10
        /* "#utility.yul":16020:16039   */
      add
        /* "#utility.yul":16014:16040   */
      mload
        /* "#utility.yul":16072:16120   */
      tag_311
        /* "#utility.yul":16114:16118   */
      0x1f
        /* "#utility.yul":16106:16112   */
      dup10
        /* "#utility.yul":16102:16119   */
      and
        /* "#utility.yul":16091:16100   */
      dup3
        /* "#utility.yul":16072:16120   */
      tag_131
      jump	// in
    tag_311:
        /* "#utility.yul":16064:16070   */
      dup4
        /* "#utility.yul":16057:16121   */
      sstore
        /* "#utility.yul":15979:16135   */
      pop
        /* "#utility.yul":15956:16135   */
    tag_310:
        /* "#utility.yul":16181:16182   */
      0x01
        /* "#utility.yul":16177:16178   */
      0x02
        /* "#utility.yul":16169:16175   */
      dup9
        /* "#utility.yul":16165:16179   */
      mul
        /* "#utility.yul":16161:16183   */
      add
        /* "#utility.yul":16155:16159   */
      dup9
        /* "#utility.yul":16148:16184   */
      sstore
        /* "#utility.yul":15583:16194   */
      pop
      pop
      pop
        /* "#utility.yul":15546:16433   */
    tag_302:
      pop
        /* "#utility.yul":15136:16439   */
      pop
      pop
      pop
        /* "#utility.yul":15044:16439   */
      pop
      pop
      jump	// out

    auxdata: 0xa26469706673582212200ed8957ef874f23892805edf22b500cb5f41f1211da8cbf4b33e64b8ffd7486b64736f6c63430008110033
}

