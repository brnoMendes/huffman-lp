public class Heap{

	public struct No{
		var peso: Int
		var caracter: Int
		var esquerda: Int
		var direita: Int
	}

	var raiz: Int = -1
	var vetor = [No]()

	public init(){

	}

	public func inserir(no: No){
		vetor.append(no)
		var indice = vetor.count
 
		while (vetor[indice].peso < vetor[indicePai(indice)].peso) {
			troca(indice, indice2: indicePai(indice));
			indice = indicePai(indice);
		}
	}

	public func inserir(peso: Int, caracter: Int){
		let no = No(peso: peso, caracter: caracter, esquerda: -1, direita: -1)
		vetor.append(no)
		var indice = vetor.count
 
		while (vetor[indice].peso < vetor[indicePai(indice)].peso) {
			troca(indice, indice2: indicePai(indice));
			indice = indicePai(indice);
		}
	}

	private func indicePai(indice: Int) -> Int{
		return indice/2
	}

	private func indiceEsquerda(indice: Int) -> Int{
		return indice * 2
	}

	private func indiceDireita(indice: Int) -> Int{
		return (indice * 2) + 1
	}

	private func ehFolha(indice: Int) -> Bool{
		if (indice >= (vetor.count / 2) && indice < vetor.count){
			return true;
		}
		return false;
	}

	private func troca(indice1: Int, indice2: Int){
		let auxiliar = vetor[indice1]
		vetor[indice1] = vetor[indice2]
		vetor[indice2] = auxiliar
	}

	private func minHeapify(indice: Int){
		if (!ehFolha(indice)){ 
			if (vetor[indice].peso > vetor[indiceEsquerda(indice)].peso  || vetor[indice].peso > vetor[indiceDireita(indice)].peso) {
				if (vetor[indiceEsquerda(indice)].peso < vetor[indiceDireita(indice)].peso) {
					troca(indice, indice2: indiceEsquerda(indice));
					minHeapify(indiceEsquerda(indice));
				} else {
					troca(indice, indice2: indiceDireita(indice));
					minHeapify(indiceDireita(indice));
				}
			}
		}
	}

}