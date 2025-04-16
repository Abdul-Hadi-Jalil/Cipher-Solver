from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware  # Add this import
from pydantic import BaseModel
from crypto_graphix.ciphers.atbash import Atbash, ModifiedAtbash
from crypto_graphix.ciphers.caesar import Caesar

app = FastAPI()

# Add CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins (for development only)
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

class CipherRequest(BaseModel):
    cipher: str
    operation: str
    text: str                   # plain or cipher text
    key: str | None = None      # optional as atbash dont uses it

@app.get("/")
def read_root():
    return {"message": "FastAPI is working!"}

@app.post('/cipher/')
def perform_cipher(req: CipherRequest):
    try:
        if req.cipher == 'Atbash':
            if req.operation == 'encrypt':
                result = Atbash.encrypt(req.text)
            elif req.operation == 'Decrypt':  # Added decrypt option
                result = Atbash.decrypt(req.text)
            else:
                raise ValueError("Invalid operation")
        elif req.cipher == 'Modified Atbash':
            if req.operation == 'encrypt':
                result = ModifiedAtbash.encrypt(req.text, req.key) if req.key else ModifiedAtbash.encrypt(req.text)
            elif req.operation == 'decrypt':
                result = ModifiedAtbash.decrypt(req.text, req.key) if req.key else ModifiedAtbash.decrypt(req.text)
            else:
                raise ValueError("Invalid operation")
        elif req.cipher == 'Caesar':
            if req.operation == 'encrypt':
                result = Caesar.encrypt(req.text, req.key)
            elif req.operation == 'decrypt':
                result = Caesar.decrypt(req.text, req.key)
            else:
                raise ValueError("Invalid operation")
        else:
            raise ValueError("Unsupported cipher")
        
        
        return {'result': result}
    except Exception as e:
        raise HTTPException(status_code=404, detail=str(e))