from django.http import HttpResponseBadRequest, JsonResponse
import boto3
import base64
import json


def consulta(request):

    #Obtiene el header personalizado para identificar que la peticion viene de un origen conocido
    is_ajax = request.headers.get('X-Requested-With') == 'XMLHttpRequest'

    #Si contiene el header continua con el workflow
    if is_ajax:
        #Valida si la peticion es GET
        if request.method == 'GET':
            #Inicializa una lista para contener las carpetas base de los productos
            productos = []
            #Inicializa un objeto referenciando a la libreria de S3
            s3 = boto3.resource('s3')
            #Inicializa un objeto referenciando al buckets de productos
            my_bucket = s3.Bucket('naoproyect-26092023')
            #Obtiene todos los elementos del buecket
            for my_bucket_object in my_bucket.objects.all():
                #Obtiene la base del folder del objeto de S3
                folder=my_bucket_object.key.split('/')
                #Valida si el objeto ya se encuentra en la lista para agregarlo
                #en caso de repetiirce la carpeta no se agregara a la lista de resultados
                if not folder[0] in productos:
                    productos.append(folder[0])
            #Retorna el resultado en formato JSON
            return JsonResponse({'productList': productos}, status=200) 
        #Valida si la peticion es POST
        if request.method == 'POST':
            #Obtiene el cuerpo del request
            body_unicode = request.body.decode('utf-8')
            #Serializa la cadena para poder convertirla de JSON a un formato de Objeto Python
            body = json.loads(body_unicode)
            #Obtiene la propiadad identifyer del cuerpo del campo del objeto python
            idetifyer = body['idetifyer']

            #Inicializa un objeto referenciando a la libreria de S3
            s3 = boto3.resource('s3')

            #Obtiene el recurso del bucket y codifica la cadena de bytes a un formato base64 para serializarlo
            imagen = s3.Object('naoproyect-26092023', idetifyer+'/foto.jpg').get()['Body'].read()
            image = base64.b64encode(imagen)

            #Obtiene el recurso del bucket y codifica la cadena de bytes a un formato base64 para serializarlo
            detail = s3.Object('naoproyect-26092023', idetifyer+'/info.txt').get()['Body'].read()
            detail = base64.b64encode(detail)
            #Retorna el resultado en formato JSON
            return JsonResponse({'imagen': image.decode(), 'detail': detail.decode()}, status=200) 
        else:   
            #Carga util en caso de no ser una peticion GET o POST
            return JsonResponse({'status': 'Invalid request'}, status=400)
    else:
        #Error http en caso de no contener el header que identifica el origen confiable
        return HttpResponseBadRequest('Invalid request')