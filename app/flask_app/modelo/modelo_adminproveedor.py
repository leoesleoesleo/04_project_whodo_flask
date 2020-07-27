def m_query_proveedores(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT    a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  if(a.activo = 'Y','activo',if(a.activo = 'N','inactivo','')) AS estado
		FROM conf_usuarios a
		JOIN conf_roles b ON a.id_rol = b.id_rol
		JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		WHERE b.id_rol = 2
		""")
	data = cur.fetchall()
	cur.close()
	return data	

	