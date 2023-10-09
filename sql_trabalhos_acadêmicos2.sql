-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEVDB - AC01 – Type e Variable Table
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* * * * * * INFORMAÇÕES DO GRUPO * * * * *

NOME: Myke Wellington    RA: 
NOME: Leonardo Goia      RA: 
NOME: Rebeca Cleto       RA: 
NOME: Gregory Cavalcanti RA: 
NOME: Kevyn Alexsander   RA: 2202760
*/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Dimensão "Unidade Gestora"
CREATE TABLE Dim_Unidade_Gestora (
    id_unidade_gestora INT identity(1000000,1) PRIMARY KEY,
    nome_unidade VARCHAR(255)
);

--Dimensão "Calendario"
CREATE TABLE Dim_Calendario (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    dia INT
);

--Dimensão "Orgão Subordinado"
CREATE TABLE Dim_Orgao_Subordinado (
    cod_org_subordinado INT identity(2000000,1) PRIMARY KEY,
    nome_org_subordinado VARCHAR(255)
);

--Dimensão "Unidade Orçamentária"
CREATE TABLE Dim_Unidade_Orcamentaria (
    cod_unid_orcamentaria INT identity(3000000,1) PRIMARY KEY,
    nome_unid_orcamentaria VARCHAR(255)
);

--Dimensão "Função"
CREATE TABLE Dim_Funcao (
    cod_funcao INT identity(4000000,1) PRIMARY KEY,
    nome_funcao VARCHAR(255)
);

--Dimensão "Orgão Superior"
CREATE TABLE Dim_Orgao_Superior (
    cod_org_superior INT identity(5000000,1) PRIMARY KEY,
    nome_org_superior VARCHAR(255)
);

--Dimensão "Categoria Econômica"
CREATE TABLE Dim_Categoria_Economica (
    id_categoria_economica INT identity(6000000,1) PRIMARY KEY,
    nome_categoria VARCHAR(255)
);

--Dimensão "Municipio"
CREATE TABLE Dim_Municipio (
    id_municipio INT identity(7000000,1) PRIMARY KEY,
    nome_municipio VARCHAR(255),
    UF VARCHAR(2)
);

--Dimensão "Ação Orçamentária"
CREATE TABLE Dim_Acao_Orcamentaria (
    id_acao INT identity(8000000,1) PRIMARY KEY,
    nome_acao VARCHAR(255)
);

--Dimensão "Programa do Governo"
CREATE TABLE Dim_Programa_Governo (
    id_programa_governo INT identity(9000000,1) PRIMARY KEY,
    nome_programa_governo VARCHAR(255)
);

--Fato "Despesas Públicas" com chave surrogate
CREATE TABLE Fato_Despesas_Publicas (
    id_despesa INT identity(11000000,1) PRIMARY KEY,
    data DATE,
    id_municipio INT,
    id_unidade_gestora INT,
    cod_org_superior INT,
    cod_org_subordinado INT,
    cod_funcao INT,
    cod_unid_orcamentaria INT,
    nome_prog_orcamentario VARCHAR(255),
    mod_despesa VARCHAR(255),
    nome_gp_despesa VARCHAR(255),
    val_empenhado DECIMAL(10, 2),
    val_liquidado DECIMAL(10, 2),
    val_pago DECIMAL(10, 2),
    id_categoria_economica INT,
    id_acao INT,
    id_programa_governo INT,
    FOREIGN KEY (data) REFERENCES Dim_Calendario(data),
    FOREIGN KEY (id_municipio) REFERENCES Dim_Municipio(id_municipio),
    FOREIGN KEY (id_unidade_gestora) REFERENCES Dim_Unidade_Gestora(id_unidade_gestora),
    FOREIGN KEY (cod_org_superior) REFERENCES Dim_Orgao_Superior(cod_org_superior),
    FOREIGN KEY (cod_org_subordinado) REFERENCES Dim_Orgao_Subordinado(cod_org_subordinado),
    FOREIGN KEY (cod_funcao) REFERENCES Dim_Funcao(cod_funcao),
    FOREIGN KEY (cod_unid_orcamentaria) REFERENCES Dim_Unidade_Orcamentaria(cod_unid_orcamentaria),
    FOREIGN KEY (id_categoria_economica) REFERENCES Dim_Categoria_Economica(id_categoria_economica),
    FOREIGN KEY (id_acao) REFERENCES Dim_Acao_Orcamentaria(id_acao),
    FOREIGN KEY (id_programa_governo) REFERENCES Dim_Programa_Governo(id_programa_governo)
);
