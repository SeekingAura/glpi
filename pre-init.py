from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

# GLPI folders
Path(BASE_DIR, "glpi/etc/glpi").mkdir(parents=True, exist_ok=True)
Path(BASE_DIR, "glpi/lib/glpi").mkdir(parents=True, exist_ok=True)
Path(BASE_DIR, "glpi/php/conf.d").mkdir(parents=True, exist_ok=True)
Path(BASE_DIR, "glpi/www/glpi").mkdir(parents=True, exist_ok=True)

# Mysql
Path(BASE_DIR, "mysql").mkdir(parents=True, exist_ok=True)
