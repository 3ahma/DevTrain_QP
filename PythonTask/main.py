from fastapi import FastAPI
import subprocess

app = FastAPI()

@app.get("/")
async def get_process():
    my_processes = []
    processes = subprocess.run(["ps", "aux"], capture_output=True, text=True)
    process_count = 0
    process_info = processes.stdout.splitlines()[1:]
    for process in process_info:
        if process_count == 50:
            break
        
        info = process.split(None, 10)
        my_process_name = info[10]
        my_process_memory_usage = float(info[3])
        my_processes.append({
            "name": my_process_name,
            "memory_usage": my_process_memory_usage
        })
        process_count += 1
    return {"processes": my_processes}