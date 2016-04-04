public class Huffman{

	public func Huffman(opcao: Bool, diretorioEntrada: String, diretorioSaida: String) {
		let arquivo = ManipuladorArquivo()

		if(opcao == true){
			// Caso a opção seja de Compactação.
			let compactador = Compactador()
			if let texto = arquivo.lerArquivoASCII(diretorioEntrada){
				print("Compactando")
				let dadoCompactado = compactador.compactar(texto)
				print("Compactado")
				arquivo.escreverArquivoBinario(diretorioSaida, dados: dadoCompactado)
				print("Saída em", diretorioSaida)
			}
		} else {
			// Caso a opção seja de Descompactação.
			let descompactador = Descompactador()
			if let dados = arquivo.lerArquivoBinario(diretorioEntrada){
				print("Descompactando")
				let dadoDescompactado = descompactador.descompactar(dados)
				print("Descompactado")
				arquivo.escreverArquivoASCII(diretorioSaida, dados: dadoDescompactado)
				print("Saída em", diretorioSaida)
			}
		}
	}
}