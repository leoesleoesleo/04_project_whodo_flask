def m_query_sugerircategorias(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT id_sugerircategoria,
			   categoria,
			   creacion,
			   if(activo = 'Y','activo',if(activo = 'N','inactivo','')) AS estado
	    FROM conf_sugerircategorias
		""")
	data = cur.fetchall()
	cur.close()
	return data