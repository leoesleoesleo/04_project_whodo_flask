def m_query_proveedores(mysql,id_usuario):
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
		WHERE a.id_usuario = %s
		AND b.id_rol = 2
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_productos_usuario(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM prov_productos a
		LEFT JOIN prov_portafolio b ON a.id_portafolio_productos = b.id_portafolio
		WHERE b.id_usuario = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_portafolio_usuario(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM prov_portafolio
		WHERE id_usuario = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data			

def m_query_usuarios(mysql,rol):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM conf_usuarios
		WHERE id_rol = %s
		""",(rol,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_categorias(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM prov_categorias 
		""")
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_select_categoria(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT id_categoria,categoria
		FROM prov_categorias
		""")
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_select_portafolio(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT id_portafolio,portafolio
		FROM prov_portafolio
		WHERE id_usuario = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_portafolio(mysql,usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_portafolio,d.nombres,a.portafolio,c.categoria
		FROM prov_portafolio a
		LEFT JOIN prov_portafoliocategoria b ON a.id_portafolio = b.id_portafolio
		LEFT JOIN prov_categorias c ON b.id_categoria = c.id_categoria
		LEFT JOIN conf_usuarios d ON a.id_usuario = d.id_usuario
		WHERE d.email = %s
		""",(usuario,))
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_productos(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_producto,
			   b.portafolio,
		       a.nombre,
		       a.precio,
		       a.productos,
		       a.descripcion,
		       if(a.activo = 'Y','activo',if(a.activo = 'N','inactivo','')) AS estado
		FROM prov_productos a
		LEFT JOIN prov_portafolio b ON a.id_portafolio_productos = b.id_portafolio
		WHERE b.id_usuario = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_existeportafolio(mysql,usuario,nom_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT count(1) fre
		FROM prov_portafolio
		WHERE id_usuario = %s
		AND portafolio = %s
		""",(usuario,nom_portafolio))
	data = cur.fetchall()
	cur.close()
	return data

def m_query_existeproductosenportafolio(mysql,id_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(id_producto) fre
		FROM prov_portafolio a
		LEFT JOIN prov_productos b ON a.id_portafolio = b.id_portafolio_productos
		AND a.id_portafolio = %s
		""",(id_portafolio,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_insert_portafolio(mysql,usuario,nom_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO prov_portafolio (id_usuario, portafolio) VALUES (%s, %s)
				""",(usuario,nom_portafolio))
	mysql.connection.commit()
	cur.close()
	return 'insert'	

def m_query_idportafolio(mysql,usuario,nom_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT id_portafolio
		FROM prov_portafolio
		WHERE id_usuario = %s
		AND portafolio = %s
		""",(usuario,nom_portafolio))
	data = cur.fetchall()
	cur.close()
	return data

def m_insert_portafoliocategoria(mysql,id_portafolio,id_categoria):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO prov_portafoliocategoria (id_categoria, id_portafolio) VALUES (%s, %s)
				""",(id_categoria,id_portafolio))
	mysql.connection.commit()
	cur.close()
	return 'insert'		

def m_query_existesugcategoria(mysql,sugerir_categoria):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT *
		FROM prov_categorias
		WHERE categoria = %s
		""",(sugerir_categoria,))
	data = cur.fetchall()
	cur.close()
	return data

def m_insert_sugerecategoria(mysql,usuario,sugerir_categoria,creacion,activo):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO conf_sugerircategorias (id_usuario, categoria, creacion, activo) VALUES (%s, %s, %s, %s)
				""",(usuario,sugerir_categoria,creacion,activo))
	mysql.connection.commit()
	cur.close()
	return 'insert'		

def insert_productos(mysql,id_portafolio,nombre,precio,descripcion,productos,activo,creacion):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO prov_productos (id_portafolio_productos, nombre, precio, descripcion, productos, activo, creacion) VALUES (%s, %s, %s, %s, %s, %s, %s)
				""",(id_portafolio,nombre,precio,descripcion,productos,activo,creacion))
	mysql.connection.commit()
	cur.close()
	return 'insert'		

def m_eliminar_producto(mysql,id_producto):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE 
				FROM prov_productos
				WHERE id_producto = %s
				""",(id_producto,))
	mysql.connection.commit()
	cur.close()
	return 'delete'	

def m_eliminar_portafolio(mysql,id_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE 
				FROM prov_portafolio
				WHERE id_portafolio = %s
				""",(id_portafolio,))
	mysql.connection.commit()
	cur.close()
	return 'delete'	

def m_eliminar_portafoliocategoria(mysql,id_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE 
				FROM prov_portafoliocategoria
				WHERE id_portafolio = %s
				""",(id_portafolio,))
	mysql.connection.commit()
	cur.close()
	return 'delete'		

def m_query_bandeja_proveedor(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_solicitud,
		       if(a.tipo=1,'Cotización',if(a.tipo=2,'Pedido','none')) tipo,
		       a.observacion,
		       a.estado,
		       a.activo
		FROM clie_carrito b
		JOIN clie_solicitud a ON b.id_solicitud = a.id_solicitud
		WHERE b.id_cliente = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_solic_pendientes(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM clie_solicitud
		WHERE id_usuario = %s
		AND estado = 1
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_solic_gestionadas(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM clie_solicitud
		WHERE id_usuario = %s
		AND estado = 2
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data			

def m_query_pedidos_pendientes(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM clie_solicitud
		WHERE id_usuario = %s
		AND estado = 1
		AND tipo = 2
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_pedidos_gestionados(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM clie_solicitud
		WHERE id_usuario = %s
		AND estado = 2
		AND tipo = 2
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_productosbandejaproveedor(mysql,id_solicitud):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_solicitud,
		       a.id_carrito, 
			   a.id_cliente,
			   a.id_proveedor,
			   d.nombres cliente,
			   e.nombres proveedor,
			   c.nombre producto,
			   a.cantidad,
			   if(a.estado = 1,'pendiente',if(a.estado = 2,'enviado',if(a.estado = 3,'gestionado','none'))) estado_carrito,
			   if(b.estado = 1,'recibido',if(b.estado = 2,'gestionado','none')) estado_solicitud
		FROM clie_carrito a
		LEFT JOIN clie_solicitud b ON a.id_solicitud = b.id_solicitud
		LEFT JOIN prov_productos c ON a.id_producto = c.id_producto
		LEFT JOIN conf_usuarios d ON a.id_cliente = d.id_usuario
		LEFT JOIN conf_usuarios e ON a.id_proveedor = e.id_usuario
		WHERE a.estado = 2 
		AND b.estado = 1 
		AND a.id_solicitud = %s
		""",(id_solicitud,))
	data = cur.fetchall()
	cur.close()
	return data	
