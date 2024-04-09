import customtkinter as ctk
from sqlalchemy import create_engine
from sqlalchemy.sql import text
import sqlalchemy
import pandas as pd   
import numpy as np

    
engine = create_engine('postgresql://postgres:Rasengan2003!@localhost:5432/ProjetoBD')

# Test the connection
connection = engine.connect() 
print("Connected successfully!")

ctk.set_appearance_mode('dark')
ctk.set_default_color_theme('dark-blue')
ctk.set_widget_scaling(1)
ctk.set_window_scaling(1)

window = ctk.CTk()
window.geometry('1280x720')

title = ctk.CTkLabel(window, text = 'Sistema de Gerenciamento de Eletrônicos',
                     font = ("Helvetica", 25) )
title.pack(padx = 10, pady = 60)

entry = ctk.CTkEntry(window, width = 50)

window.mainloop()




