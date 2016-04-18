let args = [String](Process.arguments)
var entrada = args[2]
var saida = args[3]
var opcao = Int(args[1]) == 0 ? false : true

let huffman = Huffman()
huffman.Huffman(opcao, diretorioEntrada: entrada, diretorioSaida: saida)
