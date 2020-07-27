
def m_validar_usuario(mysql,usuario):
	cur = mysql.connection.cursor()
	cur.execute("""
			SELECT a.id_usuario,
				   a.email,
				   b.rol,
				   a.nombres,				   
				   c.ciudad,
				   if(a.activo = "Y",'activo',if(a.activo = "N",'inactivo','')) AS estado
			FROM conf_usuarios a
			LEFT JOIN conf_roles b ON a.id_rol = b.id_rol
			LEFT JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
			WHERE a.email = %s
		""",(usuario,))
	data = cur.fetchall()
	cur.close()
	return data

def m_validar_psw(mysql,psw_sha256,usuario):
	cur = mysql.connection.cursor()
	cur.execute("""
			SELECT *
			FROM conf_usuarios
			WHERE clave = %s
			AND email = %s
		""",(psw_sha256,usuario,))
	data = cur.fetchall()
	cur.close()
	return data

def m_query_rol(mysql,rol):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT id_rol
		FROM conf_roles
		WHERE rol = %s
		""",(rol,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_insert_usuario(mysql,data):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO conf_usuarios (id_rol, id_ciudad, email, clave, nombres, apellidos, cc, fechan, telefono, direccion, descripcion, activo, creacion) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
				""",(data['id_rol'],data['id_ciudad'],data['email'],data['clave'],data['nombres'],data['apellidos'],data['cc'],data['fechan'],data['telefono'],data['direccion'],data['descripcion'],data['activo'],data['creacion']))
	mysql.connection.commit()
	cur.close()
	return 'insert'	

  