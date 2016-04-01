import Foundation

public class Huffman{

	public func Huffman(opcao: Bool, diretorioEntrada: String, diretorioSaida: String) {
		let arquivo = ManipuladorArquivo()
		if(opcao == true){
			let compactador = Compactador()
			if let texto = arquivo.lerArquivoASCII(diretorioEntrada){
				print("Compactando")
				compactador.compactar(texto)
				print("Compactado")
				arquivo.escreverArquivoBinario(diretorioSaida, dados: compactador.dadoCompactado)
				print("Saída em", diretorioSaida)
			}
		} else {
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