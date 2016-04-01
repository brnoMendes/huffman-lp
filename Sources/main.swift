let args = [String](Process.arguments)

let huffman = Huffman()

var entrada = args[2]
var saida = args[3]

var opcao = Int(args[1]) == 0 ? false : true

huffman.Huffman(opcao, diretorioEntrada: entrada, diretorioSaida: saida)