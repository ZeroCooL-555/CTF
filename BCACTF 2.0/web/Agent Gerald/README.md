![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/web/Agent%20Gerald/challenge.png)


By reading the text on the webpage *http://web.bcactf.com:49156/*
we quickly realize Agent Gerald is a reference to `User-Agent`.
Using curl we can send a request with a custom User-Agent
named `Agent Gerald` and get the flag.

```bash
curl -A "Agent Gerald" http://web.bcactf.com:49156

#FLAG: bcactf{y0u_h@ck3d_5tegos@urus_1nt3lligence}
```
