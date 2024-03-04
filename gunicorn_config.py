import os
import dotenv 

dotenv.load_dotenv()

# Use Railway-provided PORT environment variable, with a fallback to 8080 if not set
port = os.getenv('PORT', '8080')

workers = int(os.getenv('GUNICORN_PROCESSES', '2'))
# threads = int(os.getenv('GUNICORN_THREADS', '4'))
bind = f"0.0.0.0:{port}"

forwarded_allow_ips = '*'
secure_scheme_headers = {'X-Forwarded-Proto': 'https'}
