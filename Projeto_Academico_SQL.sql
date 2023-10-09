-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LSQL - AC03 - DDL, DML e DQL
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* * * * * * INFORMAÇÕES DO GRUPO * * * * *
Número do Grupo: 2
Tema: Locadora

NOME COMPLETO: Kevyn Alexsander Machado Klen da Silva    RA: 2202760
NOME COMPLETO: Leonardo Goia Konigame				     RA: 
NOME COMPLETO: Myke Wellington Espanhol				     RA: 
NOME COMPLETO: Gregory Henrique Cavalcanti Alves Leite	 RA: 
NOME COMPLETO: Rebeca Cleto       			             RA: 
*/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE veiculo
( 
idveiculo smallint identity(1,1)
, modelo varchar(50) not null 
, ano smallint not null
, fabricante varchar(50) not null
, placa char (7) not null
, constraint pkveiculo primary key (idveiculo)
)

CREATE TABLE locatario
( 
CPF char(11) not null
, nome varchar(100) not null 
, contato char(11) not null
, endereco varchar(100) not null
, email varchar(50) not null
, constraint pkCPF primary key (CPF)
)

CREATE TABLE locacao
( 
idcontrato int identity(1,1)
, diaria smallint not null 
, diaslocados tinyint not null
, datacontrato date not null
, idveiculo smallint not null
, CPF char(11) not null
, constraint pkcontrato primary key (idcontrato)
, constraint fkveiculo foreign key (idveiculo) references veiculo(idveiculo)
, constraint fkCPF foreign key (CPF) references locatario(CPF)

)

insert veiculo (modelo, ano, fabricante, placa) values
     ('Opala','1964', 'Chevrolet' , 'CPT1790')
    ,('Fox' , '2017', 'Wolksvagem', 'BTC1807')
	,('Lamborghini Sesto Elemento','2012','Lamborghini','WER2934')
	,('KA','2020','Ford','CFG5236')
	,('Discovery','2011','LandRover','FDS3780')
	,('Renegade','2021','JEEP','TDC9964')

insert locatario(CPF,nome,contato,endereco,email) values
     ('05375685162', 'Alexandre Santos', '11975851765' , 'Rua 23 de Maio, - 500- São Paulo', 'alexandre.s@gmail.com')
    ,('01054071525', 'Larissa Monteiro', '85958632040', 'Avenida Kennedy - 13- São Bernardo do Campo','larissa.m@gmail.com')
    ,('06234587612', 'Gabriel Souza', '1598725786', 'Rua Silva Bueno - 896- São Paulo','gabriel.s@gmail.com')
	,('35829456715', 'Raissa Leal dos Santos', '61943572561', 'Rua Carlos Livieiro- 300- São Paulo','Raissa.s@gmail.com')
    ,('34880786524', 'Carlos Eduardo Junior' , '68975172832', 'Avenida Paulista, 900- São Paulo', 'carlos.jr@gmail.com')
    ,('07865347225', 'Gabriela Silva' , '11998564517', 'Rua Doutor Baeta Neves, 400- São Bernardo do Campo', 'gabi.silva@outlook.com')


insert locacao(diaria,diaslocados,datacontrato,idveiculo,CPF) values
	 ('100','10','20221220','1','07865347225')
	,('3500','3','20221225','3','35829456715')
	,('150','4','20231226','2','06234587612')
	,('228','5','20230407','4','34880786524')
	,('665','3','20230408','6','01054071525')
	,('235','1','20230408','5','34880786524')
	,('665','6','20230414','6','01054071525')
	,('3500','2','20230414','3','35829456715')
	,('100','1','20230415','1','06234587612')
	,('150','1','20230417','2','01054071525')
	,('228','2','20230417','4','05375685162')
	,('150','10','20230419','2','34880786524')

-- Qual seria o total gasto por cada locatário após o período de locação?
select	locatario.nome as 'Nome do Cliente'
		, SUM(locacao.diaria*locacao.diaslocados) as 'Valor Total'
from	locacao inner join locatario 
                   on locacao.CPF = locatario.CPF 
group by locatario.nome

--__________________________________________________________________________________________________________________________
--Em uma ocorrência criminal, ocorrida no dia 17/04/2023, foi descoberto que  o carro utilizado no crime
--era um FOX 2017 alugado com a placa BTC1807. Sabendo disso, vincule quais CPFs estão atrelados ao carro suspeito.
select locatario.nome as 'Nome do Cliente'
      ,locatario.CPF
      ,locacao.datacontrato as 'Data da locação'
	  ,veiculo.modelo
	  ,veiculo.placa
from locacao inner join locatario 
                on locacao.CPF = locatario.CPF 
			 inner join veiculo
			    on locacao.idveiculo = veiculo.idveiculo
where veiculo.placa = 'BTC1807' and locacao.datacontrato = '20230417'
