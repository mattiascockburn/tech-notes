# OpenSSL Foo

## CSR

### Create new CSR

```sh
mydomain='foobar.example.org'
openssl req -new -newkey rsa:4096 -nodes -keyout "${mydomain}.key" -out "${mydomain}.csr"
```


### Convert from PB7 to PEM

```sh
openssl pkcs7 -inform der -in mycert.p7b -out mycert.cer
```

