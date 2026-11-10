# SMARTLEARN

## Start der Anwendung ohne Docker

1. In Ordner `SMARTLEARN/backend` gehen.

2. Ausführen in der Konsole.

```ps1
fastapi dev app/main.py
```

3.  Erwarteter Output:
```
(.venv) PS C:\Users\lh\.development\SMARTLEARN\backend> fastapi dev app/main.py

 ⚡️ Starting FastAPI in development mode
 
 🐍 Using import string: app.main:app
 
 🌐 Server started at http://127.0.0.1:8000
    Documentation at http://127.0.0.1:8000/docs
 
  Logs:
 
 ▕  Will watch for changes in these directories: ['C:\\Users\\lh\\ development\\SMARTLEARN\\backend']
 ▕  Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
 ▕  Started reloader process [14832] using WatchFiles
 ▕  Started server process [4560]
 ▕  Waiting for application startup.
 ▕  Application startup complete.
 ```

## Start der Anwendung mit Docker

1. In Ordner `SMARTLEARN` gehen.

2. Ausführen in der Konsole.

 ```ps1
docker compose up --build
 ```