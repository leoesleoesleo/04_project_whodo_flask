def m_query_usuarios(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT    a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.apellidos,
				  a.cc,
				  a.fechan,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  if(a.activo = 'Y','activo',if(a.activo = 'N','inactivo','')) AS estado
		FROM conf_usuarios a
		JOIN conf_roles b ON a.id_rol = b.id_rol
		JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		WHERE b.id_rol = 1
		""")
	data = cur.fetchall()
	cur.close()
	return data

def m_eliminar_calificacion(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE 
				FROM clie_calificacion
				WHERE id_usuario = %s
				""",(id_usuario,))
	mysql.connection.commit()
	cur.close()
	return 'delete'	

def m_eliminar_cliente(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE 
				FROM conf_usuarios
				WHERE id_usuario = %s
				""",(id_usuario,))
	mysql.connection.commit()
	cur.close()
	return 'delete'	

def m_actualizar_usuario(mysql,ciudad,usuario,nombre,apellido,cedula,fecha_nac,descripcion,activo,actualizacion,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
				UPDATE conf_usuarios SET id_ciudad = %s, email = %s, nombres = %s, apellidos = %s, cc = %s, fechan = %s , descripcion = %s, activo = %s, actualizacion = %s 
				WHERE id_usuario = %s
				""",(ciudad,usuario,nombre,apellido,cedula,fecha_nac,descripcion,activo,actualizacion,id_usuario))
	mysql.connection.commit()
	cur.close()
	return 'update'		

def m_id_ciudad(mysql,ciudad):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT id_ciudad
		FROM conf_ciudad
		WHERE ciudad = %s
		""",(ciudad,))
	data = cur.fetchall()
	cur.close()
	return data	