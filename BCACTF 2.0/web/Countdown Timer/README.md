![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/web/Countdown%20Timer/challenge.png)

Looking at the javascript under the `<script>` tag we quickly see that
in the code if the variable `time` is lower or equal to zero it goes ahead and calls
the function `getflag()`. Because this code is running client side we can manipulate the timer.

- Start the timer
- Open up inspect elements and go to the console tab
- set the timer variable to 0 by passing in this command `time = 0`
- Now the flag should be displayed on the webpage

**FLAG: bcactf{1_tH1nK_tH3_CtF_w0u1D_b3_0v3r_bY_1O0_dAy5}**
