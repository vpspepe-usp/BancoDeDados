import customtkinter as ctk
from sqlalchemy import create_engine
from sqlalchemy.sql import text
import sqlalchemy
import pandas as pd   
import numpy as np
import streamlit as st
import json

def executa_query(query):
    query = text(query)
    try:
        result = connection.execute(query)
        df = pd.DataFrame(result.fetchall(), columns=result.keys())
        df = df.loc[:,~df.columns.duplicated()].copy()
        print(df)
        st.table(df)
    except:
        st.error("Erro ao executar a query")

def show_query(query_result):
    df = pd.DataFrame(query_result.fetchall(), columns=query_result.keys())
    st.table(df)

# Read the JSON file
with open('consultas.json') as file:
    queries = json.load(file)

engine = create_engine('postgresql://postgres:Rasengan2003!@localhost:5432/ProjetoBD')
#engine = create_engine('postgresql://usuario:senha@localhost:5432/nome_do_bd')
#

# Test the connection
connection = engine.connect() 
print("Connected successfully!")


#############################   STREAMLIT   ########################################


st.set_page_config(
    page_title="Sistema de Gerenciamento de Componentes Eletrônicos",
    layout="wide",
    initial_sidebar_state="expanded",
    page_icon="Back.jpg"
)

st.markdown(
    f'<h1 style="text-align: center; font-family: Helvetica; font-size: 36px;">Sistema de Gerenciamento de Eletrônicos</h1>',
    unsafe_allow_html=True
)

show_image = st.button("Exibir Diagrama ER")
hide_image = st.button("Esconder Diagrama ER")

if show_image:
    st.image("DiagramaER.png", caption="Diagrama entidade-relacionamento do banco de dados")

if hide_image:
    st.empty()
    #image = st.image("DiagramaER.png", caption="Diagrama entidade-relacionamento do banco de dados")


#queries e tabelas
cols = st.columns(2)

with cols[0]:
    st.subheader("Insira sua Query SQL aqui!")
    query = st.text_area("")
    if st.button("Executar Query", type="primary"):
        executa_query(query)
    
with cols[1]:
    st.subheader("Queries pré-definidas")
    option = st.selectbox(
        "Escolha uma das queries abaixo",
        (queries.keys()),
        index=None,
        placeholder="Selecione uma opção"
    )
    if st.button("Executar Query listada", type="primary"):
        executa_query(queries[option])

############################## CREATE #####################################################

with cols[0]:
    st.subheader("Inserir Dados")

    c_query_tabelas = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
    c_tabelas_df = pd.read_sql_query(c_query_tabelas, connection)
    c_tabelas = c_tabelas_df['table_name'].tolist()
    c_tabela_selecionada = st.selectbox("Selecione uma tabela:", c_tabelas)

    # 2. Leitura das colunas
    query_colunas = f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{c_tabela_selecionada}'"
    c_colunas_df = pd.read_sql_query(query_colunas, connection)
    c_colunas = c_colunas_df['column_name'].tolist()
    c_tipos = c_colunas_df['data_type'].tolist()

    # 3. Coleta de entradas do usuário
    valores = []
    for coluna, tipo in zip(c_colunas, c_tipos):
        if tipo == 'integer':
            valor = st.number_input(f"Digite o valor para {coluna} (float):", format="%f", key=coluna)
        else:
            valor = st.text_input(f"Digite o valor para {coluna}:", key=coluna)
        # Adicione condições para outros tipos conforme necessário
        valores.append(valor)
    # 4. Inserção dos dados no banco de dados
    if st.button("Inserir dados",type="primary"):
        colunas_str = ", ".join(c_colunas)
        valores_formatados = ", ".join([f"'{v}'" if isinstance(v, str) else str(v) for v in valores])
        query_insert = text(f"INSERT INTO {c_tabela_selecionada} ({colunas_str}) VALUES ({valores_formatados})")
        connection.execute(query_insert)
        connection.commit()
        st.success("Dados inseridos com sucesso!")
    
############################## READ #####################################################

with cols[1]:
    st.subheader("Consultar Dados")

    r_query_tabelas = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
    r_tabelas_df = pd.read_sql_query(r_query_tabelas, connection)
    r_tabelas = r_tabelas_df['table_name'].tolist()
    r_tabela_selecionada = st.selectbox("Selecione a tabela:", r_tabelas)

    query = f"SELECT * FROM {r_tabela_selecionada} LIMIT 0"  # Uma forma de obter os nomes das colunas sem dados
    df = pd.read_sql_query(query, connection)
    colunas = df.columns.tolist()
    r_coluna_selecionada = st.selectbox("Selecione a coluna para visualizar:", colunas)
    numero_joins = int(st.number_input("Digite o número de joins (0 se nenhum):", format="%f", key="joins"))
    
    r_tab_join = [r_tabela_selecionada]
    r_cols_join = [r_coluna_selecionada]
    join_query = ""
    for i in range(numero_joins):
        r_tab_join.append(st.selectbox(f"Selecione a tabela de join {i+1}:", r_tabelas))
        query = f"SELECT * FROM {r_tab_join[i]} LIMIT 0"
        df = pd.read_sql_query(query, connection)
        colunas = df.columns.tolist()
        r_cols_join.append(st.selectbox(f"Selecione a coluna de join {i+1}:", colunas))
        join_query += f" JOIN {r_tab_join[i+1]} ON {r_tab_join[i]}.{r_cols_join[i]} = {r_tab_join[i+1]}.{r_cols_join[i+1]}"
        

    query_read = f'SELECT * FROM {r_tabela_selecionada}' + join_query + ";"
    r_button = st.button("Executar Query", type="primary", key = "read_Button")
    if r_button:
        print(query_read)
        executa_query(query_read)

    
############################## UPDATE #####################################################
with cols[0]:    
    st.subheader("Atualizar Dados")

    u_query_tabelas = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
    u_tabelas_df = pd.read_sql_query(u_query_tabelas, connection)
    u_tabelas = u_tabelas_df['table_name'].tolist()
    u_tabela_selecionada = st.selectbox("Selecione a Tabela:", u_tabelas)

    # Passo 2: Selecionar a Coluna
    with engine.connect() as conn:
        consulta_colunas = text(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{u_tabela_selecionada}'")
        resultado_colunas = conn.execute(consulta_colunas, {'table_name': u_tabela_selecionada}).fetchall()
    colunas = [coluna[0] for coluna in resultado_colunas]

    u_id_para_atualizar = st.number_input("Digite o ID da linha para atualizar:", format="%f", key = "update")

    u_coluna_selecionada = st.selectbox("Selecione a coluna para atualização:", colunas)

    

    # Passo 4: Fornecer Novo Valor
    u_novo_valor = st.text_input(f"Digite o novo valor para {u_coluna_selecionada}:", "")

    # Passo 5: Executar a Operação de Atualização
    if st.button("Atualizar",type="primary"):
        with engine.connect() as conn:
            consulta_update = text(f"UPDATE {u_tabela_selecionada} SET {u_coluna_selecionada} = '{text(u_novo_valor)}' WHERE {'id_'+u_tabela_selecionada} = {u_id_para_atualizar}")
            print(consulta_update)
            conn.execute(consulta_update)
            conn.commit()
        st.success("Linha atualizada com sucesso!")

############################## DELETE #####################################################
with cols[1]:    
    st.subheader("Deletar Dados")

    d_query_tabelas = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
    d_tabelas_df = pd.read_sql_query(d_query_tabelas, connection)
    d_tabelas = d_tabelas_df['table_name'].tolist()
    d_tabela_selecionada = st.selectbox("SELECIONA A TABELA", d_tabelas)

    # Passo 2: Selecionar a Coluna
    with engine.connect() as conn:
        consulta_colunas = text(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{d_tabela_selecionada}'")
        resultado_colunas = conn.execute(consulta_colunas, {'table_name': d_tabela_selecionada}).fetchall()
    colunas = [coluna[0] for coluna in resultado_colunas]

    d_coluna_selecionada = st.selectbox("Selecione a coluna para atualização:", colunas, key = "delete")

        # Passo 3: Especificar o Valor
    d_valor = st.text_input("Digite o valor para identificar as linhas a serem deletadas:")

    # Passo 4: Executar a Operação de Deleção
    if st.button("Deletar Linhas"):
        with engine.connect() as conn:
            query_delete = text(f"DELETE FROM {d_tabela_selecionada} WHERE {d_coluna_selecionada} = {d_valor}")
            conn.execute(query_delete)
            conn.commit()
            st.success("Linhas deletadas com sucesso!")


st.markdown(
    """
    <style>
    div[class*="stTextInput"] label {
    font-size: 35px;
    color: red;
}

div[class*="stSelectbox"] label {
    font-size: 35px;
    color: red;
}
    </style>
    """,
    unsafe_allow_html=True,
)

connection.close()


















    


