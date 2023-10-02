from django.http import HttpResponse
from django.template import loader


def root(request):
    template = loader.get_template("root/index.html")
    context = {
    }
    return HttpResponse(template.render(context, request))