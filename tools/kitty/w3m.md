Fixes for w3m images in kitty

```
alias w3m="w3m -o inline_img_protocol=4 -o imgdisplay='/usr/bin/kitten icat'" 
```

`~/.w3m/config` 
```
inline_img_protocol 4
imgdisplay /usr/bin/kitten icat 2>/dev/null
```
