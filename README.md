# huffman-lp
Codificação de Huffman - Linguagens de programação 2016/1 - UTFPR - @brnomendes e @mairieli

* Compactação: Arquivo ASCII --> Arquivo Binário
* Descompactação: Arquivo Binário --> Arquivo ASCII

```
$ swift --verion
Swift version 2.2-dev (LLVM 3ebdbb2c7e, Clang f66c5bb67b, Swift 42591f7cba)
Target: x86_64-unknown-linux-gnu

$ swift build --version
Apple Swift Package Manager 0.1
```

### Execução
```
$ git clone https://github.com/brnoMendes/huffman-lp.git
$ cd huffman-lp
$ swift build
```
##### Compactar
```
$ .build/debug/Huffman 1 /arquivo/ascii /arquivo/binario
```
##### Descompactar
```
$ .build/debug/Huffman 0 /arquivo/binario /arquivo/ascii
```
