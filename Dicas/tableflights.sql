--8. Crie a coluna qa_origin_dest e aponte inconsistências da coluna origin, dest de acordo com as regras abaixo:


--MO : Indica que está com dado faltante no origin.

--MD : Indica que está com dado faltante no dest.

--RO : Indica que o aeroporto origem está ausente no dataset airports.

--RD : Indica que o aeroporto destino está ausente no dataset airports.

--9. Crie a coluna qa_air_time e aponte inconsistencias da coluna air_time de acordo com as regras abaixo:
-- M : Indica que está com dado faltante.

--I : Indica que o valor excede o intervalo [20, 500].

--F :Indica que o valor não é numérico.

--10. Crie a coluna qa_distance e aponte inconsistências da coluna distance de acordo com as regras abaixo:

--M : Indica que está com dado faltante.

--I : Indica que o valor excede o intervalo [50, 3000].

--11. Crie a coluna qa_distance_airtime e aponte inconsistências entre as colunas distance e air_time de acordo com as regras abaixo:

--M : Indica que está com distance ou air_time faltante.

--TL : Indica que a viagem é longa de acordo com a condição: air_time >= distance × 0.1 + 30.

--TS : Indica que a viagem é curta de acordo com a condição: air_time <= distance × 0.1 + 10.

--TR : Indica que a viagem é normal caso as duas anteriores não sejam verdade. 









