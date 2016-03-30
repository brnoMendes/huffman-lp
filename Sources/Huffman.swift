import Foundation

public class Huffman{

	public func Huffman(opcao: Bool, diretorioEntrada: String, diretorioSaida: String) {
		let arquivo = ManipuladorArquivo()
		if(opcao == true){
			let compactador = Compactador()
			if let texto = arquivo.lerArquivoASCII(diretorioEntrada){
				compactador.compactar(texto)
				arquivo.escreverArquivoBinario(diretorioSaida, dados: compactador.dado)
			}
		} else {
			let descompactador = Descompactador()
		}
	}
}