![Challenge](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/web/Home%20Automation/challenge.png)

Navigating to the website and trying to turn the lights off
We are prompted with an error **You must be admin to turn off the lights. Currently you are "vampire"**
After seeing this message the immediate thought is to check the cookie for any values.

After looking at the cookie we can see a user value and it's set to vampire,
changing the value to admin and refreshing, we get the flag.

![Flag](https://github.com/ZeroCooL-555/CTF/blob/master/BCACTF%202.0/web/Home%20Automation/flag.png)
