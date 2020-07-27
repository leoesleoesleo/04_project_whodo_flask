from flask import Flask, render_template, request, redirect, url_for, flash, session 
#from flask_wtf import CsrfProtect #pip install Flask-WTF
from flask_mail import Mail #pip install Flask-Mail
from flask_mail import Message
import os
import time
import pandas as pd
#pip install xlrd

from werkzeug import secure_filename #pip install Werkzeug
import pandas as pd
import config.conexion as conexion
from config.config import DevelopmentConfig
import controlador.controlador_seguridad as c_seg

import modelo.modelo_seguridad as m_seguridad
import modelo.modelo_adminusuarios as m_admin_usuario
import modelo.modelo_adminproveedor as m_admin_proveedor
import modelo.modelo_admincategorias as m_admin_categorias
import modelo.modelo_proveedor as m_proveedor
import modelo.modelo_cliente as m_cliente
 

app = Flask(__name__)
app.config.from_object(DevelopmentConfig)
#csrf = CsrfProtect(app)
"""
headers: {
            'X-CSRF-TOKEN' : $('meta[name="csrf-token"]').attr('content')
        },
"""
mail = Mail()

# Carpeta de subida
app.config['UPLOAD_FOLDER'] = 'ficheros'
ALLOWED_EXTENSIONS = set(['xlsx','xls'])

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# conexión mysql
mysql = conexion.con_mysql(app)

@app.route('/')
def index():
    return render_template('logueo/logueo.html')

@app.route('/logueo',methods=['POST'])
def logueo():
    if request.method == 'POST':
        usuario       = request.form['usuario']
        psw           = request.form['psw']
        res = c_seg.c_seguridad(mysql,usuario,psw)
        """
        if res == 'OK':
            msg = Message('Gracias por tu registro', 
                        sender = app.config['MAIL_USERNAME'],
                        recipients = [usuario] )
            msg.html = render_template('email.html', username = usuario)
            mail.send(success_message)
        """
    else:
        res = "usuarioErroneo"            
    return res

@app.route('/logout')
def logout():
    session.clear()
    return render_template('logueo/logueo.html')

@app.route('/inicio',methods=['POST','GET'])
def inicio():
    try:
        session['usuario']
    except KeyError:
        return render_template('logueo/logueo.html')
    else:
        return render_template('index.html')

@app.route('/v_bandeja',methods=['POST','GET'])
def v_bandeja():
    if request.method == 'POST':
        param                 = request.form['param']
        rol                  = session['rol'] 

    id_usuario               = session['id_'] 
    data_solic_pendientes    = m_proveedor.m_query_solic_pendientes(mysql,id_usuario)[0][0]
    data_solic_gestionadas   = m_proveedor.m_query_solic_gestionadas(mysql,id_usuario)[0][0]
    data_pedidos_pendientes  = m_proveedor.m_query_pedidos_pendientes(mysql,id_usuario)[0][0]
    data_pedidos_gestionados = m_proveedor.m_query_pedidos_gestionados(mysql,id_usuario)[0][0]
    if rol == 'cliente' or rol == 'super':
        data_bandeja_proveedor   = m_proveedor.m_query_bandeja_proveedor(mysql,id_usuario)
    elif rol == 'proveedor':
        data_bandeja_proveedor   = m_cliente.m_query_bandeja_cliente(mysql,id_usuario)
        

    data = {
            'data_solic_pendientes'    : data_solic_pendientes,
            'data_solic_gestionadas'   : data_solic_gestionadas,
            'data_pedidos_pendientes'  : data_pedidos_pendientes,
            'data_pedidos_gestionados' : data_pedidos_gestionados,
            'data_bandeja_proveedor'   : data_bandeja_proveedor,
            'param'                    : param 
           } 
    return render_template('proveedor/v_bandeja.html',data=data)

@app.route('/v_proveedor',methods=['POST','GET'])
def v_proveedor():
    usuario         = session['usuario']
    id_usuario      = session['id_'] 
    rol_cliente     = 1 
    data_portafolio = m_proveedor.m_query_portafolio(mysql,usuario)
    data_productos  = m_proveedor.m_query_productos(mysql,id_usuario)
    data_proveedor  = m_proveedor.m_query_proveedores(mysql,id_usuario)

    data_resum_prod = m_proveedor.m_query_productos_usuario(mysql,id_usuario)[0][0]
    data_resum_port = m_proveedor.m_query_portafolio_usuario(mysql,id_usuario)[0][0]
    data_resum_cate = m_proveedor.m_query_categorias(mysql)[0][0]
    data_resum_usua = m_proveedor.m_query_usuarios(mysql,rol_cliente)[0][0]

    data = {
            'data_portafolio' : data_portafolio,
            'data_productos'  : data_productos,
            'data_proveedor'  : data_proveedor,
            'data_resum_prod' : data_resum_prod,
            'data_resum_port' : data_resum_port,
            'data_resum_cate' : data_resum_cate,
            'data_resum_usua' : data_resum_usua
           } 
    return render_template('proveedor/v_proveedor.html',data=data)


@app.route('/v_carrito',methods=['POST','GET'])
def v_carrito():
    if request.method == 'POST':
        param                 = request.form['param']

        if param == 'carrito':  
            id_cliente            = request.form['id_cliente']
            id_portafolio         = request.form['id_portafolio']
            data_carrito_data     = m_cliente.m_query_carrito_data(mysql,id_cliente,id_portafolio)
        elif param == 'none':
            data_carrito_data     = 0
                 
        data = {
                'data_carrito_data':data_carrito_data
                }    
    return render_template('cliente/v_cliente_carrito.html',data=data)    

@app.route('/v_cliente',methods=['POST','GET'])
def v_cliente():
    rol_proveedor = 2 

    data_proveedor = m_cliente.m_query_proveedores(mysql)

    data_resum_prod = m_cliente.m_query_productos(mysql)[0][0]
    data_resum_port = m_cliente.m_query_portafolio(mysql)[0][0]
    data_resum_cate = m_proveedor.m_query_categorias(mysql)[0][0]
    data_resum_usua = m_proveedor.m_query_usuarios(mysql,rol_proveedor)[0][0]

    data = {
            'data_proveedor':data_proveedor,
            'data_resum_prod':data_resum_prod,
            'data_resum_port':data_resum_port,
            'data_resum_cate':data_resum_cate,
            'data_resum_usua':data_resum_usua

           }
    return render_template('cliente/v_cliente.html',data=data)    
        
@app.route('/v_admin_usuarios',methods=['POST','GET'])
def v_admin_usuarios():
    data_usuarios = m_admin_usuario.m_query_usuarios(mysql)
    data = {
            'data_usuarios':data_usuarios
           }
    return render_template('administrador/usuarios/v_admin_usuarios.html',data=data)

@app.route('/c_eliminarusuario',methods=['POST'])
def c_eliminarusuario():
    if request.method == 'POST':
        id_usuario   = request.form['id_usuario']

        delete = m_admin_usuario.m_eliminar_calificacion(mysql,id_usuario)
        if delete == 'delete':
            delete = m_admin_usuario.m_eliminar_cliente(mysql,id_usuario)
            if delete == 'delete':
                return "Registrodelete"
            else:
                return "Error"    
        else:
            return "Error"

@app.route('/c_modal_actualizar_cliente',methods=['POST'])
def c_modal_actualizar_cliente():
    if request.method == 'POST':
        id_usuario        = request.form['id']
        usuario           = request.form['usuario']
        nombre            = request.form['nombre']
        apellido          = request.form['apellido']
        cedula            = request.form['cedula']
        telefono          = request.form['telefono']
        fecha_nac         = request.form['fecha_nac']        
        direccion         = request.form['direccion']
        descripcion       = request.form['descripcion']
        ciudad            = request.form['ciudad']
        activo            = request.form['activo']

        data = {
                'id_usuario':id_usuario,
                'usuario':usuario,
                'nombre':nombre,
                'apellido':apellido,
                'cedula':cedula,
                'telefono':telefono,
                'fecha_nac':fecha_nac,
                'direccion':direccion,
                'descripcion':descripcion,
                'ciudad':ciudad,
                'activo':activo
                }
        return render_template('administrador/usuarios/modal_actualizarcliente.html', data=data)

@app.route('/c_actualizar_usuario',methods=['POST'])
def c_actualizar_usuario():
    if request.method == 'POST':
        id_usuario   = request.form['id_usuario']
        nombre       = request.form['_nombre']
        apellido     = request.form['_apellido']
        cedula       = request.form['_cedula']
        fecha_nac    = request.form['_fecha_nac']
        descripcion  = request.form['_descripcion']
        usuario      = request.form['_usuario']
        ciudad       = request.form['_ciudad']
        activo       = request.form['_activo']        
        actualizacion= time.strftime("%Y-%m-%d %H:%M:%S")

        try:
            int(ciudad)
        except ValueError:
            ciudad = m_admin_usuario.m_id_ciudad(mysql,ciudad) 

        if activo == '1':
            _activo = 'Y'
        elif activo == 'activo':
            _activo = 'Y'                
        elif activo == '2':
            _activo = 'N'
        elif activo == 'inactivo':
            _activo = 'N'
               

        data = {            
            'ciudad'      : ciudad,
            'usuario'     : usuario,
            'nombre'      : nombre,
            'apellido'    : apellido,
            'cedula'      : cedula,
            'fecha_nac'   : fecha_nac,
            'descripcion' : descripcion,
            '_activo'     : _activo,
            'actualizacion': actualizacion,
            'id_usuario'  : id_usuario
        }
    
        update = m_admin_usuario.m_actualizar_usuario(mysql,ciudad,usuario,nombre,apellido,cedula,fecha_nac,descripcion,_activo,actualizacion,id_usuario)

        if update == 'update':
            return "Registroupdate"
        else:
            return "Error"

@app.route('/c_modal_actualizar_proveedor',methods=['POST'])
def c_modal_actualizar_proveedor():
    if request.method == 'POST':
        id_usuario        = request.form['id']
        usuario           = request.form['usuario']
        empresa           = request.form['empresa']
        nit               = request.form['nit']
        telefono          = request.form['telefono']    
        direccion         = request.form['direccion']
        descripcion       = request.form['descripcion']
        ciudad            = request.form['ciudad']
        activo            = request.form['activo']

        data = {
                'id_usuario':id_usuario,
                'usuario':usuario,
                'empresa':empresa,
                'nit':nit,
                'telefono':telefono,
                'direccion':direccion,
                'descripcion':descripcion,
                'ciudad':ciudad,
                'activo':activo
                }
        return render_template('administrador/proveedor/modal_actualizarproveedor.html', data=data)


@app.route('/v_admin_proveedor',methods=['POST','GET'])
def v_admin_proveedor():
    data_proveedor   = m_admin_proveedor.m_query_proveedores(mysql)
    data = {
            'data_proveedor':data_proveedor
           }    
    return render_template('administrador/proveedor/v_admin_proveedor.html',data=data)

@app.route('/v_admin_categorias',methods=['POST','GET'])
def v_admin_categorias():
    data_categorias = m_admin_categorias.m_query_sugerircategorias(mysql)
    data = {
            'data_categorias':data_categorias
           }    
    return render_template('administrador/categorias/v_admin_categorias.html',data=data)


@app.route('/insert_usuario',methods=['POST'])
def insert_usuario():
    if request.method == 'POST':

        data = {
            'rol'         : request.form['rol'],
            'nombre'      : request.form['nombre'],
            'apellido'    : request.form['apellido'],
            'cedula'      : request.form['cedula'],
            'correo'      : request.form['correo'],
            'ciudad'      : request.form['ciudad'],
            'direccion'   : request.form['direccion'],
            'contraseña'  : request.form['contraseña'],
            'telefono'    : request.form['telefono'],
            'descripcion' : request.form['descripcion'],
            'fechan'      : request.form['fechan']   
        }

        #print(data)         
        res = c_seg.c_nuevousuario(mysql,data)
           
    return res

@app.route('/listarselectcategoria',methods=['POST','GET'])
def listarselectcategoria():
    data_select_categoria = m_proveedor.m_query_select_categoria(mysql)
    data = {
            'data_select_categoria':data_select_categoria
            }
    return render_template('proveedor/select_categoria.html', data=data)

@app.route('/listarselectcategoriafiltro',methods=['POST','GET'])
def listarselectcategoriafiltro():
    data_select_categoria = m_proveedor.m_query_select_categoria(mysql)
    data = {
            'data_select_categoria':data_select_categoria
            }
    return render_template('cliente/select_categoria.html', data=data)    

@app.route('/listarselectportafolio',methods=['POST','GET'])
def listarselectportafolio():
    id_usuario             = session['id_'] 
    data_select_portafolio = m_proveedor.m_query_select_portafolio(mysql,id_usuario)
    data = {
            'data_select_portafolio':data_select_portafolio
            }
    return render_template('proveedor/select_portafolio.html', data=data)  

@app.route('/agregarportafolio',methods=['POST'])
def agregarportafolio():
    if request.method == 'POST':

        nom_portafolio    = request.form['nom_portafolio']
        id_categoria      = request.form['select_categoria']
        usuario           = session['id_']

        #validar que no exista portafolio
        res = m_proveedor.m_query_existeportafolio(mysql,usuario,nom_portafolio)[0][0]
        if res >= 1:
            return 'portafolioDuplicado'
        else:                     
            #insertarportafolio
            res = m_proveedor.m_insert_portafolio(mysql,usuario,nom_portafolio)
            if res == 'insert':
                id_portafolio = m_proveedor.m_query_idportafolio(mysql,usuario,nom_portafolio)[0]
                res = m_proveedor.m_insert_portafoliocategoria(mysql,id_portafolio,id_categoria)    

            if res == 'insert':
                return "RegistroInsert"
            else:
                return "Error" 

@app.route('/sugerir_categoria',methods=['POST'])
def sugerir_categoria():
    if request.method == 'POST':

        sugerir_categoria = request.form['sugerir_categoria']
        usuario           = session['id_']
        activo            = 'Y',
        creacion          = time.strftime("%Y-%m-%d %H:%M:%S")

        #validar que la sugerencia categoria no exista
        res = m_proveedor.m_query_existesugcategoria(mysql,sugerir_categoria)
        #print("*********************************************************",sugerir_categoria)
        if len(res) >= 1:
            return 'duplicado'
        else:                     
            #insertarportafolio
            res = m_proveedor.m_insert_sugerecategoria(mysql,usuario,sugerir_categoria,creacion,activo)

            if res == 'insert':
                return "RegistroInsert"
            else:
                return "Error" 

@app.route("/upload", methods=['POST'])
def upload():
    if request.method == 'POST':
        # obtenemos el archivo del input "archivo"
        f = request.files['inputArchivoCargaVentasHide']
        filename = secure_filename(f.filename)
        if f.filename == '':
            res = "nodata"
        if f and allowed_file(f.filename):
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], 'plantilla.xlsx'))
            #capturar data
            id_portafolio     = request.form['portafolio']
            activo            = 'Y',
            creacion          = time.strftime("%Y-%m-%d %H:%M:%S")

            #INSERTAR FICHERO EXCEL
            df = pd.read_excel('ficheros/plantilla.xlsx', sheet_name='Hoja1')
            #validar
            if df.columns[0] == 'Nombre' and df.columns[1] == 'Precio' and df.columns[2] == 'Descripción':
                try:
                    df.iloc[:,3][0]
                except Exception as e:
                    print("Debe tener al menos un producto")
                else:
                    i = 0
                    n = len(df)
                    while i < n:
                        nombre      = df.loc[i:i,'Nombre'][i]
                        precio      = df.loc[i:i,'Precio'][i]
                        descripcion = df.loc[i:i,'Descripción'][i]
                        productos   = df.iloc[i:(i+1),3:].to_json(orient='records')
                        print("insert bd", nombre,precio,descripcion,productos)
                        res = m_proveedor.insert_productos(mysql,id_portafolio,nombre,precio,descripcion,productos,activo,creacion)
                        i += 1        
            else:
                res = "noformato"              
        else:   
            res = "noextension"    
  
        return res
        

@app.route('/c_eliminarportafolio',methods=['POST'])
def c_eliminarportafolio():
    if request.method == 'POST':
        id_portafolio   = request.form['id_portafolio']
        #validar que el portafolio no tenga productos
        res = m_proveedor.m_query_existeproductosenportafolio(mysql,id_portafolio)[0][0]
        if res == 0:
            delete = m_proveedor.m_eliminar_portafoliocategoria(mysql,id_portafolio)
            if delete == 'delete':
                delete = m_proveedor.m_eliminar_portafolio(mysql,id_portafolio)
            else:
                delete = 'none'

            if delete == 'delete':
                return "RegistroDelete"
            else:
                return "Error"
        else:
            return 'existeproductos'         

@app.route('/c_eliminarproducto',methods=['POST'])
def c_eliminarproducto():
    if request.method == 'POST':
        id_producto   = request.form['id_producto']

        delete = m_proveedor.m_eliminar_producto(mysql,id_producto)

        if delete == 'delete':
            return "RegistroDelete"
        else:
            return "Error"            

@app.route('/listarselectciudad',methods=['POST','GET'])
def listarselectciudad():
    data_select_ciudad = m_cliente.m_query_select_ciudad(mysql)
    data = {
            'data_select_ciudad':data_select_ciudad
            }
    return render_template('cliente/select_ciudad.html', data=data)

@app.route('/listarselectciudad_logueo',methods=['POST','GET'])
def listarselectciudad_logueo():
    data_select_ciudad = m_cliente.m_query_select_ciudad(mysql)
    data = {
            'data_select_ciudad':data_select_ciudad
            }
    return render_template('logueo/select_ciudadlogueo.html', data=data)    

@app.route('/tablafiltro_cliente',methods=['POST','GET'])
def tablafiltro_cliente():
    data_proveedor  = m_cliente.m_query_proveedores(mysql)
    data = {
            'data_proveedor':data_proveedor
            }
    return render_template('cliente/tabla_filtro_cliente.html', data=data)

@app.route('/filtro_cliente',methods=['POST','GET'])
def filtro_cliente():
    if request.method == 'POST':

        param               = request.form['param']
        select_ciudad       = request.form['select_ciudad']
        select_categoria    = request.form['select_categoria']
        select_calificacion = request.form['select_calificacion']
        #precio_ini          = request.form['texrangoprecioini']
        #precio_fin          = request.form['texrangopreciofin']

        if (param == 'Ciudad' or param == 'Categoria' or param == 'Calificación') and select_ciudad == '-- Todas Las Ciudades --' and select_categoria == '-- Todas Las Categorias --' and select_calificacion == '-- Todas Las Calificaciones --':
            data_proveedor = m_cliente.m_query_proveedores(mysql)
            print("******************************************m_query_proveedores1")
        elif (param == 'Ciudad' or param == 'Categoria' or param == 'Calificación') and select_categoria == '-- Todas Las Categorias --' and select_calificacion == '-- Todas Las Calificaciones --':
            data_proveedor = m_cliente.m_query_filtrocliente_ciudad(mysql,select_ciudad)
            print("******************************************m_query_filtrocliente_ciudad")
        elif (param == 'Ciudad' or param == 'Categoria' or param == 'Calificación') and select_categoria == '-- Todas Las Categorias --' and select_calificacion != '-- Todas Las Calificaciones --' and select_ciudad != '-- Todas Las Ciudades --':
            data_proveedor = m_cliente.m_query_filtrocliente_ciudad_calificacion(mysql,select_ciudad,select_calificacion)
            print("******************************************m_query_filtrocliente_ciudad_calificacion")  
        elif (param == 'Ciudad' or param == 'Categoria' or param == 'Calificación') and select_categoria != '-- Todas Las Categorias --' and select_calificacion != '-- Todas Las Calificaciones --' and select_ciudad == '-- Todas Las Ciudades --':
            data_proveedor = m_cliente.m_query_filtrocliente_calificacion_categoria(mysql,select_calificacion,select_categoria)
            print("******************************************m_query_filtrocliente_calificacion_categoria")           
        elif (param == 'Categoria' or param == 'Calificacion' or param == 'Ciudad') and select_ciudad == '-- Todas Las Ciudades --' and select_calificacion == '-- Todas Las Calificaciones --' and select_categoria != '-- Todas Las Categorias --':
            data_proveedor = m_cliente.m_query_filtrocliente_categoria(mysql,select_categoria)
            print("******************************************m_query_filtrocliente_categoria")
        elif (param == 'Calificacion' or param == 'Ciudad' or param == 'Categoria') and select_ciudad != '-- Todas Las Ciudades --' and select_calificacion == '-- Todas Las Calificaciones --':
            data_proveedor = m_cliente.m_query_filtrocliente_categoria_ciudad(mysql,select_categoria,select_ciudad)  
            print("******************************************m_query_filtrocliente_categoria_ciudad")  
        elif (param == 'Calificacion' or param == 'Ciudad' or param == 'Categoria') and select_ciudad == '-- Todas Las Ciudades --' and select_categoria == '-- Todas Las Categorias --' and select_calificacion != '-- Todas Las Calificaciones --':
            data_proveedor = m_cliente.m_query_filtrocliente_calificacion(mysql,select_calificacion)
            print("******************************************m_query_filtrocliente_calificacion")
        elif (param == 'Calificacion' or param == 'Ciudad' or param == 'Categoria') and select_ciudad != '-- Todas Las Ciudades --' and select_categoria == '-- Todas Las Categorias --':
            data_proveedor = m_cliente.m_query_filtrocliente_ciudad_calificacion(mysql,select_ciudad,select_calificacion)
            print("******************************************m_query_filtrocliente_ciudad_calificacion2")
        elif (param == 'Calificacion' or param == 'Ciudad' or param == 'Categoria') and select_ciudad != '-- Todas Las Ciudades --' and select_categoria != '-- Todas Las Categorias --':
            data_proveedor = m_cliente.m_query_filtrocliente_calificacion_ciudad_categoria(mysql,select_calificacion,select_ciudad,select_categoria)
            print("******************************************m_query_filtrocliente_calificacion_ciudad_categoria")
        elif param == 'Calificacion' and select_ciudad == '-- Todas Las Ciudades --' and select_categoria != '-- Todas Las Categorias --' and select_calificacion != '-- Todas Las Calificaciones --':
            data_proveedor = m_cliente.m_query_filtrocliente_calificacion_categoria(mysql,select_calificacion,select_categoria)
            print("******************************************m_query_filtrocliente_calificacion_categoria")
        else:
            data_proveedor = m_cliente.m_query_proveedores(mysql)
            print("******************************************m_query_proveedoresELSE")             
        data = {
                'data_proveedor':data_proveedor
                }
    return render_template('cliente/tabla_filtro_cliente.html', data=data)


@app.route('/portafolios_proveedor',methods=['POST','GET'])
def portafolios_proveedor():
    if request.method == 'POST':

        id_cliente       = request.form['id']
        data_portafolio  = m_cliente.m_query_portafolios(mysql,id_cliente)
        data_productos   = m_cliente.m_query_productos_porta(mysql,id_cliente)
        data = {
                'data_portafolio':data_portafolio,
                'data_productos' :data_productos
                }
        return render_template('cliente/tabla_portafolio_productos.html', data=data)
  

@app.route('/insert_producto',methods=['POST'])
def insert_producto():
    if request.method == 'POST':
        cantidad           = request.form['cantidad']
        id_producto        = request.form['id_producto']
        id_cliente         = session['id_']
        id_proveedor       = request.form['id_proveedor']

        insert = m_cliente.m_insert_producto(mysql,id_cliente,id_proveedor,cantidad,id_producto)

        if insert == 'insert':
            return "RegistroInsert"
        else:
            return "Error"
        
@app.route('/c_tabla_carrito',methods=['POST','GET'])
def c_tabla_carrito():
    id_cliente    = session['id_']
    data_carrito  = m_cliente.m_query_carrito(mysql,id_cliente)
    data_cantidad = m_cliente.m_query_carrito_cantidad(mysql,id_cliente)[0][0]
    data_valor    = m_cliente.m_query_carrito_valor(mysql,id_cliente)[0][0]
    data = {
            'data_carrito'  : data_carrito,
            'data_cantidad' : data_cantidad,
            'data_valor'    : data_valor
            }
    return render_template('cliente/tabla_productos_carrito2.html', data=data)


@app.route('/eliminarproductocarrito',methods=['POST'])
def eliminarproductocarrito():
    id_              = request.form['id']
    eliminarproducto = m_cliente.m_eliminarproductocarrito(mysql,id_)

    if eliminarproducto == 'delete':
        return "RegistroEliminado"
    else:
        return "Error"   

@app.route('/c_solicitud',methods=['POST'])
def c_solicitud():
    if request.method == 'POST':        
        id_usuario       = session['id_']
        creacion         = time.strftime("%Y-%m-%d %H:%M:%S")
        tiposolicitud    = request.form['select_tiposolicitud']
        observacion      = request.form['observacion']
        estado           = 1
        activo           = 'Y'   
        #crear solicitud insert en solicitudes 
        insert = m_cliente.m_insert_solicitud(mysql,id_usuario,tiposolicitud,estado,activo,creacion,observacion)
        if insert == 'insert':
            #consultar solicitud
            id_solicitud = m_cliente.m_query_id_solicitud(mysql,id_usuario,creacion)[0][0]
            #consultar proveedores que estan en el carrito
            id_proveedores = m_cliente.m_query_proveedoresencarrito(mysql,id_usuario)  

            i = 0
            n = len(id_proveedores)
            while i < n:
                #print(id_proveedores[i][0],"****************************************")
                #actualizar carrito al estado 2 (enviado) y agregar el id de la solicitud (nota: si hay productos de varios proveedores quedarán bajo la misma solicitud)
                data_actualizar_carrito = m_cliente.m_actualizar_carrito(mysql,id_usuario,id_proveedores[i][0],id_solicitud) 
                if data_actualizar_carrito == 'update':
                    i = i + 1
                else:
                    print('Error')
                    break                
        #armar query para la bandeja del proveedor jugando con el estado de la solicitud y el estado del carrito
        #insert = m_cliente.m_insert_producto(mysqltiposolicitud)

        if insert == 'insert' and data_actualizar_carrito == 'update':
            return "ok"
        else:
            return "Error" 


@app.route('/c_modal_verproductosbandejaproveedor',methods=['POST','GET'])
def c_modal_verproductosbandejaproveedor():
    if request.method == 'POST':

        id_solicitud                     = request.form['id']
        data_productosbandejaproveedor = m_proveedor.m_query_productosbandejaproveedor(mysql,id_solicitud)
        data = {
                'data_productosbandejaproveedor':data_productosbandejaproveedor
                }
        return render_template('proveedor/tabla_bandeja_productos.html', data=data)

@app.route('/c_actualizar_bandeja',methods=['POST'])
def c_actualizar_bandeja():
    if request.method == 'POST':
        id_usuario         = session['id_'] 
        id_solicitud       = request.form['id_bandeja']
        estado             = request.form['_estado']
        activo             = request.form['_activo'] 
        calificacion       = request.form['calificacion'] 

        calificacion       = m_cliente.m_calificacion(mysql,calificacion,id_usuario)
        if calificacion == 'update':
            actualizar_bandeja = m_cliente.m_actualizar_solicitudbandeja(mysql,id_solicitud,estado,activo)

            if actualizar_bandeja == 'update':
                return "RegistroActualizado"
        else:
            return "Error"  

if __name__ == "__main__":
    #csrf.init_app(app)
    app.run()
    mail.init_app(app)


