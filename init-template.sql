-- User for GLPI
-- mysql_native_password is recommended for PHP systems
CREATE USER IF NOT EXISTS 'glpi_user'@'%' IDENTIFIED WITH mysql_native_password BY 'password here CHANGE';
CREATE USER IF NOT EXISTS 'glpi_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password here CHANGE';

-- Enable access to timezone
GRANT SELECT ON `mysql`.`time_zone_name` TO 'glpi_user'@'localhost';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'glpi_user'@'%';

-- Database for glpi
CREATE DATABASE IF NOT EXISTS glpi_db;

-- Grant privileges glpi user to glpi db
GRANT ALL PRIVILEGES ON glpi_db.* TO 'glpi_user'@'localhost';
GRANT ALL PRIVILEGES ON glpi_db.* TO 'glpi_user'@'%';

-- Update privileges
FLUSH PRIVILEGES;
