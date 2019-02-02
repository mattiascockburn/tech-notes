# TLS

## Quickly get cert chain

`openssl s_client -connect my-super-url:443 -showcerts </dev/null | openssl x509 -text`

