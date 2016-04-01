public class Arvore{

	public func constroiArvore(frequencia: [Int]) -> No<Int> {

		var arvore = [No<Int>()]
		arvore.removeLast()

		// Criar uma Arvore para cada Caracter.
		for i in 0...127 {
			if(frequencia[i] > 0) {
				let no = No<Int>()
				no.inserir(Int(frequencia[i]), caracter: UInt8(i))
				arvore.append(no)
			}
		}

		// Construir a Arvore
		while arvore.count > 1 {
			ordena(&arvore)
			let novoNo = No<Int>()
			let no1 = arvore.removeFirst()
			let no2 = arvore.removeFirst()
			novoNo.peso = no1.peso! + no2.peso!
			no1.pai = novoNo
			no2.pai = novoNo
			novoNo.inserir(no1, direita: no2)
			arvore.append(novoNo)
		}

		return arvore.removeFirst()
	}

	private func ordena(inout vetor: [No<Int>]) {
		
		let tam = vetor.count - 1
		
		for i in 0...tam {
			let atual = vetor[i]
			var j = i-1
			while (j >= 0 && atual.peso < vetor[j].peso) {
				vetor[j+1] = vetor[j]
	            j = j-1
			}	    
			vetor[j+1] = atual
		}
	}
}