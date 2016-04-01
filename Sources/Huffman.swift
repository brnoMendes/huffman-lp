import Foundation

public class Huffman{

	public func Huffman(opcao: Bool, diretorioEntrada: String, diretorioSaida: String) {
		let arquivo = ManipuladorArquivo()
		if(opcao == true){
			let compactador = Compactador()
			if let texto = arquivo.lerArquivoASCII(diretorioEntrada){
				compactador.compactar(texto)
				arquivo.escreverArquivoBinario(diretorioSaida, dados: compactador.dadoCompactado)
			}
		} else {
			let descompactador = Descompactador()
			if let dados = arquivo.lerArquivoBinario(diretorioEntrada){
				let dadoDescompactado = descompactador.descompactar(dados)
				arquivo.escreverArquivoASCII(diretorioSaida, dados: dadoDescompactado)
			}
		}
	}
}