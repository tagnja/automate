# automate
My automatic scripts.



Execute bash script directly from a URL

```shell
$ curl -s https://example.com/script.sh | bash
$ bash <(curl -Ls https://example.com/script.sh)
$ bash <(wget -qO- https://example.com/script.sh)
$ wget -qO- https://example.com/script.sh | bash # -q == --quiet -O- == --output-document
```

Execute bash script passing parameters

```shell
$ curl -s https://example.com/script.sh | bash -s arg1 arg2 arg3 #  "-s" to read from stdin.
```
