--8. Crie a coluna qa_origin_dest e aponte inconsist�ncias da coluna origin, dest de acordo com as regras abaixo:


--MO : Indica que est� com dado faltante no origin.

--MD : Indica que est� com dado faltante no dest.

--RO : Indica que o aeroporto origem est� ausente no dataset airports.

--RD : Indica que o aeroporto destino est� ausente no dataset airports.

--9. Crie a coluna qa_air_time e aponte inconsistencias da coluna air_time de acordo com as regras abaixo:
-- M : Indica que est� com dado faltante.

--I : Indica que o valor excede o intervalo [20, 500].

--F :Indica que o valor n�o � num�rico.

--10. Crie a coluna qa_distance e aponte inconsist�ncias da coluna distance de acordo com as regras abaixo:

--M : Indica que est� com dado faltante.

--I : Indica que o valor excede o intervalo [50, 3000].

--11. Crie a coluna qa_distance_airtime e aponte inconsist�ncias entre as colunas distance e air_time de acordo com as regras abaixo:

--M : Indica que est� com distance ou air_time faltante.

--TL : Indica que a viagem � longa de acordo com a condi��o: air_time >= distance � 0.1 + 30.

--TS : Indica que a viagem � curta de acordo com a condi��o: air_time <= distance � 0.1 + 10.

--TR : Indica que a viagem � normal caso as duas anteriores n�o sejam verdade. 









