Arbitrage Trading Formula Derivations
=====================================

[Go up to the main HW page](index.html) ([md](index.md))

### How much to trade formula derivation

Let's define some variables, all of which are known quantities.

- $g$ is the gas fees in ETH
- $p_{e}$ is the price of ETH in USD
- $p_{t}$ is the price of TC in USD
- $q_{e}$ is how much ETH you have in your holdings (as a float: so 10.0 ETH, not 10000000000000000000 wei)
- $q_{t}$ is how much TC you have in your holdings (as a float: so 100.0 TC, not 1000000000000)
- $x_{d}$, $y_{d}$, and $k_{d}$ are the values from the DEX (respectively: ether liquidity, token liqudiity, and $k$); we'll assume that these values are the floating-point values without all the extra decimals (so 1.5 for $y_t$ instead of 15000000000).  Likewise, we'll assume that $k_d=x_d \ast y_d$, meaning that it too is scaled down without all those decimals.
- $f$ is the percentage (out of 1.0) obtained after the DEX fees are removed -- if $f_n$ is the fee numerator (say, 3) and $f_d$ is the fee denominator (say, 1000), then $f=1-f_n/f_d$.  In this example, with $f_n=3$ and $f_d=1000$, $f=0.997$.  Note that this fee applies to both ETH and TC transactions.

The variable subscripts here all follow these rules:

- A subscript of $t$ means it represents a value related to the TC (price, quantity, etc.)
- A subscript of $e$ means it represents a value related to the ETH (price, quantity, etc.)
- A subscript of $d$ means it represents a value of the DEX ($x$, $y$, $k$, etc.)

Your current holdings in USD are: $h_{before} = q_{e} \ast p_{e} + q_{t} \ast p_{t}$

You have two options as to how to interact with a DEX: you could trade in either ETH or TC.  We'll define those amounts as $\delta_{e}$ and $\delta_{t}$, depending on which we are trading in.

If you are trading $\delta_{t}$ TC to the DEX (note that $\delta_{t}$ must be positive):

- $q_{t}$ is decreased by $\delta_{t}$; thus the amount of TC after, which we will represent by $\omega_{t}$, is:
    - $\omega_{t} = q_{t}-\delta_{t}$
- The value of the DEX's $x_{d}$ after the transaction we'll represent by $x'_d = k_d/(y_{d}+\delta_{t})$
- The amount of ETH received: $r_{e}=f \ast (x_{d}-x'_d)$
    - This amount is added to $q_{e}$
    - As TC was traded to the DEX, $r_{e}$ will be positive, indicating a receipt of ETH, as expected
- The amount of ETH after ($\omega_{e}$) is thus:
    - $\omega_{e}= q_{e} + r_{e}$
    - $\omega_{e}= q_{e} + f \ast (x_{d}-x'_d)$
    - $\omega_{e}= q_{e} + f \ast x_{d} - f \ast k_d/(y_{d}+\delta_{t})$
- However, we have to deduct the gas fees of $g$, so the amount of ETH after is then:
    - $\omega_{e}= q_{e} + f \ast x_{d} - f \ast k_d/(y_{d}+\delta_{t})-g$
- We can then figure out our holdings after the transaction:
    - $h_{after} = \omega_{e} \ast p_{e} + \omega_{t} \ast p_{t}$
    - $h_{after} = (q_{e} + f \ast x_{d}-f \ast k_d/(y_{d}+\delta_{t})-g) \ast p_{e} + (q_{t}-\delta_{t}) \ast p_{t}$
    - We'll separate out the gas fees to make it simpler a bit later on:
    - $h_{after} = (q_{e} + f \ast x_{d}-f \ast k_d/(y_{d}+\delta_{t})) \ast p_{e} + (q_{t}-\delta_{t}) \ast p_{t} - g \ast p_e$
- We want to maximize this formula.  The only variable that we can change is how much TC we are trading in ($\delta_{t}$)
    - To do this, we are going to have to take the derivative of that function
    - Before we do, let's put it into a reduced form: $y = a + b/(c+x)+d \ast x = a + b \ast (x+c)^{-1}+d \ast x$
        - If we massage the above formula into the $y = a + b/(c+x)+d \ast x$ form, we can derive what $x$, $a$, $b$, $c$, and $d$ equal:
            - $x$, the variable we are solving for, to $x=\delta_{t}$
            - $a=q_e \ast p_e - g \ast p_e + q_t \ast p_t + p_e \ast f \ast x_d$
            - $b=-f \ast k_d \ast p_e$
            - $c=y_d$
            - $d=-p_t$
    - We take the derivative of that:
        - $y' = -b \ast (x+c)^{-2} + d$
    - To find the maxima, we set $y'=0$ and solve for $x$:
        - $y' = 0 = -b \ast (x+c)^{-2} + d$
        - $0 = -b \ast (x+c)^{-2} + d$
        - $-d = -b \ast (x+c)^{-2}$
        - $d = b \ast (x+c)^{-2}$
        - $d = b / (x+c)^2$
        - $d \ast (x+c)^2 = b$
        - $(x+c)^2=b/d$
        - $x+c=$ &#8730; $(b/d)$
        - $x=-c \pm$ &#8730; $(b/d)$
    - Recall that:
        - $x=\delta_{t}$
        - $b=-f \ast k_d \ast p_e$
        - $c=y_d$
        - $d=-p_t$
    - So we can rewrite that formula as:
        - $\delta_{t}=-y_d\pm$ &#8730; $(f \ast k_d \ast p_e/p_t)$
            - That formula does not render well in HTML, but the entire parenthetical is what we are taking the square root of
        - So once we know the DEX values ($x_d$, $y_d$, $k_d$, and the fees $f$) and the current prices ($p_e$ and $p_t$), we can compute the points for the maxima and minima
        - Note that these are not guaranteed to make a profit!  But if they do make a profit, one of them will make the *most* and/or *least* profit.
        - If we are trading in ETH, the formula is similar: $\delta_{e}=-x_d\pm$ &#8730; $(f \ast k_d \ast p_t/p_e)$
        - Because the variables in the parenthetical can never be negative, the square root will always return real values
    - We can simplify these equations somewhat.  Although there is a &#177; (plus-minus), subtracting that value would make the overall $\delta_t$ or $\delta_e$ value negative, which doesn't make sense in this case -- what we derived is how much we are trading in to the DEX, not how much we are getting out of the DEX.  So we will just replace the &#177; with a regular plus symbol.
        - If we are trading in TC: $\delta_{t}=-y_d+$ &#8730; $(f \ast k_d \ast p_e/p_t)$
        - If we are trading in ETH: $\delta_{e}=-x_d+$ &#8730; $(f \ast k_d \ast p_t/p_e)$
        - As above, those formulas do not render well in HTML, but the entire parenthetical is what we are taking the square root of
