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
        st.table(df)
    except:
        st.error("Erro ao executar a query")

# Read the JSON file
with open('consultas.json') as file:
    queries = json.load(file)

engine = create_engine('postgresql://postgres:Rasengan2003!@localhost:5432/ProjetoBD')

# Test the connection
connection = engine.connect() 
print("Connected successfully!")


#############################   STREAMLIT   ########################################


st.set_page_config(
    page_title="Sistema de Gerenciamento de Eletrônicos",
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
    query = st.text_area(r'''Insira sua query SQL aqui ''')
    if st.button("Executar Query", type="primary"):
        executa_query(query)
    
with cols[1]:
    option = st.selectbox(
        "Escolha uma das queries abaixo",
        (queries.keys()),
        index=None,
        placeholder="Selecione uma opção"
    )
    if st.button("Executar Query listada", type="primary"):
        executa_query(queries[option])

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




















    


