


def generarMatriz(tam, elemento = "1"):
	matriz = ""
	for i in xrange(tam):
		for j in xrange(tam):			
			matriz += elemento
			if ((i != tam -1) or (j != tam -1)):
				matriz += " "
	return matriz
	
def generarInput(tam):
	linea = str(tam) + " "
	linea += generarMatriz(tam)
	linea += " "
	linea += generarMatriz(tam)
	return linea
	
def generarResultado(tam):
	linea = str(tam) + " "
	linea += generarMatriz(tam, str(tam))
	return linea
	
def main():
	for i in xrange(6):
		m = generarInput(2048)
		print m

	
if __name__ == "__main__":
	main();
