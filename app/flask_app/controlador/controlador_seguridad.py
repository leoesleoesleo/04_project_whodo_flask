import modelo.modelo_seguridad as modelo
from flask import session 
import hashlib
import time

def c_seguridad(mysql,usuario,psw):
    validar_usuario = modelo.m_validar_usuario(mysql,usuario)
    if len(validar_usuario) == 1:
        for row in validar_usuario:
            id_       = row[0]
            usuario   = row[1]
            rol       = row[2]
            nombres   = row[3]
            ciudad    = row[4]
            activo    = row[5]

        if activo == 'activo':
            psw_sha256 = hashlib.sha256(psw.encode()).hexdigest()
            validar_pws = modelo.m_validar_psw(mysql,psw_sha256,usuario)
            
            if len(validar_pws) == 1:
                session['id_']       = id_
                session['usuario']   = usuario                    
                session['rol']       = rol
                session['nombres']   = nombres
                session['ciudad']    = ciudad
                session['activo']    = activo                    
                res = 'OK'
            else:
                res = 'PwdErroneo'
        else:
            res = 'desactivado'        
    else:
        res = 'usuarioErroneo'
    
    return res    

def c_nuevousuario(mysql,data):

    validar_usuario = modelo.m_validar_usuario(mysql,data['correo']) #validar que el usuario no exista  
    print("*****************************************",validar_usuario)  
    
    if len(validar_usuario) >= 1:  
        return "usuarioDuplicado" 
    else:                
        rol        = modelo.m_query_rol(mysql,data['rol'].lower())[0][0]
        data_model = {
            'id_rol'      : rol,
            'id_ciudad'   : data['ciudad'],
            'email'       : data['correo'],
            'clave'       : hashlib.sha256(data['contraseña'].encode()).hexdigest(),   
            'nombres'     : data['nombre'],
            'apellidos'   : data['apellido'],
            'cc'          : data['cedula'],
            'fechan'      : data['fechan'],
            'telefono'    : data['telefono'],
            'direccion'   : data['direccion'],
            'descripcion' : data['descripcion'],
            'activo'      : 'Y',
            'creacion'    : time.strftime("%Y-%m-%d %H:%M:%S")
        }
        #print(data_model)
        insert = modelo.m_insert_usuario(mysql,data_model)
        
        if insert == 'insert':
            return "RegistroInsert"
        else:
            return "Error"
            