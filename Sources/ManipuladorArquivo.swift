import Foundation

public class ManipuladorArquivo {

	public func lerArquivoASCII(diretorio: String) -> String? {
		let diretorioOriginal = NSString(string:diretorio).stringByExpandingTildeInPath
		do{
			let conteudoArquivo = try String(contentsOfFile: diretorioOriginal, encoding: NSASCIIStringEncoding)
			return conteudoArquivo
		} catch {
			print("Erro ao ler o arquivo", diretorio)
		}
		return nil
	}

	
	public func lerArquivoBinario(diretorio: String) -> NSData? {
		let diretorioOriginal = diretorio.stringByExpandingTildeInPath
		let conteudoArquivo: NSData? = NSData(contentsOfFile: diretorioOriginal)
		return conteudoArquivo
	}

	public func escreverArquivoASCII(diretorio: String, dados: String){
		do{
			try dados.writeToFile(diretorio, atomically: true, encoding: NSASCIIStringEncoding)
		} catch {
			print("Erro ao escrever o arquivo", diretorio)	
		}
	}

	public func escreverArquivoBinario(diretorio: String, dados: NSData){
		dados.writeToFile(diretorio, atomically: true)
	}
}