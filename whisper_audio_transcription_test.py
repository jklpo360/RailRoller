import whisper
import torch
import time

t0 = time.time()
device = 'cuda' if torch.cuda.is_available() else 'cpu'
model = whisper.load_model("base").to(device)
result = model.transcribe("hello_world.mp3")
t1 = time.time()
print(result["text"])
print("Transcribed in: " + str(t1-t0))
