public class Heap{

	public struct No{
		var peso: Int
		var caracter: Int
	}

	var raiz: Int = -1
	var vetor = [No]()

	public init(){

	}

	public func inserir(no: No){
		vetor.append(no)
		var indice = (vetor.count - 1)
 
		while (vetor[indice].peso < vetor[indicePai(indice)].peso) {
			troca(indice, indice2: indicePai(indice));
			indice = indicePai(indice);
		}
	}

	public func inserir(peso: Int, caracter: Int){
		let no = No(peso: peso, caracter: caracter)
		vetor.append(no)
		var indice = (vetor.count - 1)

		while (indice > 0 && vetor[indice].peso < vetor[indicePai(indice)].peso) {
			troca(indice, indice2: indicePai(indice));
			indice = indicePai(indice);
		}
	}

	public func minHeap(){
		for var indice = (vetor.count/2); indice > 0; (indice-=1) {
			minHeapify(indice);
		}
	}

	public func printHeap(indice: Int){
		if(indice < vetor.count){
			print(vetor[indice].peso, terminator: " ")
			printHeap(indiceEsquerda(indice))
			printHeap(indiceDireita(indice))
		}
	}

	public func remover() -> No? {
		if vetor.isEmpty {
			return nil
		} else if vetor.count == 1 {
			return vetor.removeLast()
		} else {
			let valor = vetor[0]
			vetor[0] = vetor.removeLast()
			minHeapify(0)
			return valor
		}
	}

	private func indicePai(indice: Int) -> Int{
		return (indice - 1)/2
	}

	private func indiceEsquerda(indice: Int) -> Int{
		return (indice * 2) + 1
	}

	private func indiceDireita(indice: Int) -> Int{
		return (indice * 2) + 2
	}

	private func ehFolha(indice: Int) -> Bool{
		return indiceEsquerda(indice) >= vetor.count;
	}

	private func troca(indice1: Int, indice2: Int){
		let auxiliar = vetor[indice1]
		vetor[indice1] = vetor[indice2]
		vetor[indice2] = auxiliar
	}

	private func minHeapify(indice: Int){
		if (!ehFolha(indice)){
			var menor = indice
			if(indiceEsquerda(indice) < vetor.count && vetor[menor].peso > vetor[indiceEsquerda(indice)].peso){
				menor = indiceEsquerda(indice)
			}
			if(indiceDireita(indice) < vetor.count && vetor[menor].peso > vetor[indiceDireita(indice)].peso){
				menor = indiceDireita(indice)
			}
			if(menor != indice){
				troca(indice, indice2: menor);
				minHeapify(menor);
			}
		}
	}

}