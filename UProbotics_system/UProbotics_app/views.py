from django.shortcuts import render

"""
El archivo views.py en Django es donde defines las vistas de tu aplicación
web. Las vistas son funciones o clases que reciben solicitudes HTTP y devuelven
respuestas. Aquí tienes un ejemplo básico de cómo configurar vistas en Django:"""
# Create your views here.



# Vista para la página de inicio
def home(request):
    return render(request, 'UProbotics_app/index.html')


def programadores(request):
    return render(request, 'UProbotics_app/programadores.html')

def mecatronica(request):
    return render(request, 'UProbotics_app/mecatronica.html')

def electronica(request):
    return render(request, 'UProbotics_app/electronica.html')

def administracion(request):
    return render(request, 'UProbotics_app/administracion.html')

