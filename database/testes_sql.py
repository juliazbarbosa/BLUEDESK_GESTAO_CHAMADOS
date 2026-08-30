import sqlite3

conn = sqlite3.connect('bancodedados.db') #connection
cursor = conn.cursor() #envia comandos para o banco de dados

#SEELECT * FROM chamados
cursor.execute("SELECT * FROM chamados")
print("Todos os chamados:")
for linha in cursor.fetchall(): #trazer todos os dados da tabela
    print(linha)

cursor.execute("SELECT * FROM chamados WHERE solicitante_id = ?", (1,))
print("Chamados do usuário id=1:")
for linha in cursor.fetchall():
    print(linha)

print()

cursor.execute("""
    SELECT chamados.titulo, usuarios.nome
    FROM chamados
    JOIN usuarios ON chamados.solicitante_id = usuarios.id
""")
print("Chamados com nome do solicitante:")
for linha in cursor.fetchall():
    print(linha)

conn.close() #fecha conexão com o banco de dados