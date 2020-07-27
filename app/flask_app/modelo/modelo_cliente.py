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
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		WHERE b.id_rol = 2
		AND a.activo = 'Y'
		""")
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_productos(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM prov_productos a
		LEFT JOIN prov_portafolio b ON a.id_portafolio_productos = b.id_portafolio
		""")
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_portafolio(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) fre
		FROM prov_portafolio
		""")
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_select_ciudad(mysql):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT *
		FROM conf_ciudad
		""")
	data = cur.fetchall()
	cur.close()
	return data	

	
def m_query_filtrocliente_ciudad(mysql,ciudad):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT  a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND c.id_ciudad = %s
		""",(ciudad,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_ciudad_calificacion(mysql,ciudad,calificacion):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND c.id_ciudad = %s
		AND d.calificacion = %s
		""",(ciudad,calificacion))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_categoria(mysql,categoria):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND e.id_categoria = %s
		""",(categoria,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_categoria_ciudad(mysql,categoria,ciudad):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND e.id_categoria = %s
		AND c.id_ciudad = %s
		""",(categoria,ciudad))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_calificacion(mysql,calificacion):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND d.calificacion = %s
		""",(calificacion,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_calificacion_ciudad_categoria(mysql,calificacion,ciudad,categoria):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND e.id_categoria = %s 
		AND c.id_ciudad = %s
		AND d.calificacion = %s
		""",(categoria,ciudad,calificacion))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_filtrocliente_calificacion_categoria(mysql,calificacion,categoria):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'	
		AND d.calificacion = %s
		AND e.id_categoria = %s 
		""",(calificacion,categoria))
	data = cur.fetchall()
	cur.close()
	return data	


def m_query_filtrocliente_precio(mysql,precio_ini,precio_fin):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT DISTINCT a.id_usuario,
				  a.email,	
				  a.nombres,
				  a.cc,
				  a.telefono,				  
				  a.direccion,
				  a.descripcion,				 
				  c.ciudad,		  
				  d.calificacion,
				  e.categoria
		FROM conf_usuarios a
		left JOIN conf_roles b ON a.id_rol = b.id_rol
		left JOIN conf_ciudad c ON a.id_ciudad = c.id_ciudad
		left JOIN (SELECT id_usuario,avg(calificacion) calificacion
				FROM clie_calificacion
				GROUP BY id_usuario) d ON a.id_usuario = d.id_usuario
		left JOIN (SELECT DISTINCT e.id_usuario,g.id_categoria,g.categoria
						FROM prov_portafolio e
						left JOIN prov_portafoliocategoria f ON e.id_portafolio = f.id_portafolio
						left JOIN prov_categorias g ON f.id_categoria = g.id_categoria) e ON a.id_usuario = e.id_usuario	
		LEFT JOIN prov_portafolio ee ON a.id_usuario = ee.id_usuario
		left JOIN prov_productos h ON ee.id_portafolio = h.id_portafolio_productos	
		WHERE b.id_rol = 2
		AND a.activo = 'Y'			
		-- AND e.id_categoria = 1
		-- AND a.id_ciudad = 2
		-- AND d.calificacion = 3
		AND h.precio between %s AND %s
		""",(precio_ini,precio_fin))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_carrito(mysql,id_cliente):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_carrito,b.nombre,b.precio,a.cantidad
		FROM clie_carrito a
		LEFT JOIN prov_productos b ON a.id_producto = b.id_producto
		LEFT JOIN prov_portafolio c ON b.id_portafolio_productos = c.portafolio
		WHERE a.estado = 1 
		-- AND c.id_usuario = %s
		""",(id_cliente,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_carrito_cantidad(mysql,id_cliente):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT COUNT(1) cantidad
		FROM clie_carrito a
		LEFT JOIN prov_productos b ON a.id_producto = b.id_producto
		LEFT JOIN prov_portafolio c ON b.id_portafolio_productos = c.portafolio
		WHERE a.estado = 1
		-- AND c.id_usuario = %s
		""",(id_cliente,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_carrito_valor(mysql,id_cliente):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT SUM(precio) precio
		FROM clie_carrito a
		LEFT JOIN prov_productos b ON a.id_producto = b.id_producto
		LEFT JOIN prov_portafolio c ON b.id_portafolio_productos = c.portafolio
		WHERE a.estado = 1
		-- AND c.id_usuario = %s
		""",(id_cliente,))
	data = cur.fetchall()
	cur.close()
	return data			

def m_query_carrito_data(mysql,id_usuario,id_portafolio):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT  a.id_usuario,
	    		b.id_producto,
			    a.portafolio,
			    b.nombre producto,
			    b.precio,
			    b.descripcion,
			    b.productos
		FROM prov_portafolio a
		LEFT JOIN prov_productos b ON a.id_portafolio = b.id_portafolio_productos
		WHERE a.id_usuario = %s
		AND a.id_portafolio = %s
		AND b.activo = 'Y'
		""",(id_usuario,id_portafolio))
	data = cur.fetchall()
	cur.close()
	return data		

def m_query_productos_porta(mysql,id_cliente):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT  a.id_usuario,
	    		a.id_portafolio,
			    a.portafolio,
			    b.nombre producto,
			    b.precio,
			    b.descripcion,
			    b.productos
		FROM prov_portafolio a
		LEFT JOIN prov_productos b ON a.id_portafolio = b.id_portafolio_productos
		WHERE id_usuario = %s
		AND b.activo = 'Y'
		""",(id_cliente,))
	data = cur.fetchall()
	cur.close()
	return data	

def m_query_portafolios(mysql,id_cliente):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT *
		FROM prov_portafolio
		WHERE id_usuario = %s
		""",(id_cliente,))
	data = cur.fetchall()
	cur.close()
	return data		

def m_insert_producto(mysql,id_cliente,id_proveedor,cantidad,id_producto):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO clie_carrito (id_cliente,id_proveedor,id_producto, cantidad, estado) VALUES (%s, %s, %s, %s, 1)
				""",(id_cliente,id_proveedor,id_producto,cantidad))
	mysql.connection.commit()
	cur.close()
	return 'insert'

def m_eliminarproductocarrito(mysql,id_):
	cur = mysql.connection.cursor()	
	cur.execute("""
				DELETE FROM clie_carrito
				WHERE id_carrito = %s
				""",(id_,))
	mysql.connection.commit()
	cur.close()
	return 'delete'	
		
def m_insert_solicitud(mysql,id_usuario,tiposolicitud,estado,activo,creacion,observacion):
	cur = mysql.connection.cursor()	
	cur.execute("""
				INSERT INTO clie_solicitud (id_usuario, tipo, estado, activo, creacion, observacion) VALUES (%s, %s, %s, %s, %s, %s)
				""",(id_usuario,tiposolicitud,estado,activo,creacion,observacion))
	mysql.connection.commit()
	cur.close()
	return 'insert'	

def m_query_id_solicitud(mysql,id_usuario,creacion):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT id_solicitud
		FROM clie_solicitud
		WHERE id_usuario = %s
		AND creacion = %s
		""",(id_usuario,creacion))
	data = cur.fetchall()
	cur.close()
	return data

def m_query_proveedoresencarrito(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
				SELECT DISTINCT id_proveedor
				FROM clie_carrito
				WHERE id_cliente = %s
				""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data

def m_actualizar_carrito(mysql,id_cliente,id_proveedor,id_solicitud):
	cur = mysql.connection.cursor()	
	cur.execute("""
				UPDATE clie_carrito SET estado = '2', id_solicitud = %s
				WHERE id_cliente = %s
				AND id_proveedor = %s
				""",(id_solicitud,id_cliente,id_proveedor))
	mysql.connection.commit()
	cur.close()
	return 'update'

def m_query_bandeja_cliente(mysql,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
		SELECT a.id_solicitud,
		       if(a.tipo=1,'Cotización',if(a.tipo=2,'Pedido','none')) tipo,
		       a.observacion,
		       a.estado,
		       a.activo
		FROM clie_carrito b
		JOIN clie_solicitud a ON b.id_solicitud = a.id_solicitud
		WHERE b.id_proveedor = %s
		""",(id_usuario,))
	data = cur.fetchall()
	cur.close()
	return data				

def m_actualizar_solicitudbandeja(mysql,id_solicitud,estado,activo):
	cur = mysql.connection.cursor()	
	cur.execute("""
				UPDATE clie_solicitud SET estado = %s, activo = %s
				WHERE id_solicitud = %s
				""",(estado,activo,id_solicitud))
	mysql.connection.commit()
	cur.close()
	return 'update'		

def m_calificacion(mysql,calificacion,id_usuario):
	cur = mysql.connection.cursor()	
	cur.execute("""
				UPDATE clie_calificacion SET calificacion = %s
				WHERE id_usuario = %s
				""",(calificacion,id_usuario))
	mysql.connection.commit()
	cur.close()
	return 'update'		