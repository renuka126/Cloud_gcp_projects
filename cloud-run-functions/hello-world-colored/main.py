import os

# Reading the color from an env var means I can redeploy this as a new
# revision with a different value without touching the code at all -
# that's the whole point of this exercise (orange -> yellow revision test).


color = os.environ.get('COLOR')

def hello_world(request):
    return f'<body style="background-color:{color}"><h1>Hello World!</h1></body>'