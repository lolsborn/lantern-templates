from .base import *

DEBUG = False

# Security settings for production
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_HSTS_SECONDS = 31536000
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_REFERRER_POLICY = 'strict-origin-when-cross-origin'

# Static files
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Logging for production
LOGGING['handlers']['file'] = {
    'class': 'logging.handlers.RotatingFileHandler',
    'filename': BASE_DIR / 'logs' / 'django.log',
    'maxBytes': 1024 * 1024 * 15,  # 15MB
    'backupCount': 10,
    'formatter': 'verbose',
}

LOGGING['root']['handlers'].append('file')
LOGGING['loggers']['django']['handlers'].append('file')
LOGGING['loggers']['{{project_name}}']['handlers'].append('file')

# Performance optimization
CONN_MAX_AGE = 60

# Error reporting (configure as needed)
ADMINS = [
    ('Admin', env('ADMIN_EMAIL', default='admin@example.com')),
]

SERVER_EMAIL = env('SERVER_EMAIL', default='noreply@example.com')