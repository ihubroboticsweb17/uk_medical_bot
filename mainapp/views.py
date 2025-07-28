from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.http import JsonResponse
import time
from asgiref.sync import sync_to_async

async def register_user(request):
    print("Register success")
    # await register_function_async()
    return JsonResponse({
        "status": "register success",
    }, status=status.HTTP_200_OK)

def register_function():
    print("------------------")
    print("sleeping for 10 s")
    time.sleep(10)
    print('post 10 s sleeping')

register_function_async = sync_to_async(register_function)


@api_view(['GET'])
def login_user(request):
    print("Login success")
    return JsonResponse({
        "status": "Login success",
    }, status=status.HTTP_200_OK)