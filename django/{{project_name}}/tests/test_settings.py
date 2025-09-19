import pytest
from django.test import override_settings
from django.conf import settings


def test_settings_loaded():
    """Test that settings are properly loaded."""
    assert hasattr(settings, 'INSTALLED_APPS')
    assert 'django.contrib.admin' in settings.INSTALLED_APPS
    assert 'rest_framework' in settings.INSTALLED_APPS


@override_settings(DEBUG=True)
def test_debug_setting():
    """Test debug setting override."""
    assert settings.DEBUG is True


def test_database_config():
    """Test database configuration."""
    assert 'default' in settings.DATABASES
    assert settings.DATABASES['default']['ENGINE'] == 'django.db.backends.sqlite3'


def test_rest_framework_config():
    """Test REST framework configuration."""
    assert 'DEFAULT_AUTHENTICATION_CLASSES' in settings.REST_FRAMEWORK
    assert 'DEFAULT_PERMISSION_CLASSES' in settings.REST_FRAMEWORK
    assert settings.REST_FRAMEWORK['PAGE_SIZE'] == 20