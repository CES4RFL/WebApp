Prerequisitos:

Antes de comenzar busque las acces keys y el secret para autenticar con la cuenta de IAM de AWS
busque agrega a las variables de entorno los valores de AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY

Puesta en marcha:

Una vez aprovisionada el acces key debe correr el sig comando para poder instalar las librerias necesarias
para poder hacer funcionar la aplicacion

python -m pip install -r requirements.txt

una vez instaladas para inicializar la aplicacion por favor corra el siguiente comando

python manage.py runserver

la aplicacion se inicializara en http://127.0.0.1:8000/