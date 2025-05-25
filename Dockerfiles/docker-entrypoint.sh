#!/bin/sh

# Exit on error
set -e

echo "Starting iTop..."

export PHP_APC_SHM_SIZE=${PHP_APC_SHM_SIZE:-"128M"}
export PHP_APC_TTL=${PHP_APC_TTL:-"7200"}

export PHP_TIMEZONE=${PHP_TIMEZONE:-"Europe/Paris"}

export PHP_ENABLE_UPLOADS=${PHP_ENABLE_UPLOADS:-"On"}
export PHP_MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:-"600"}
export PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-"128M"}
export PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE:-"16M"}
export PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:-"2M"}
export PHP_MAX_FILE_UPLOADS=${PHP_MAX_FILE_UPLOADS:-"20"}
export PHP_MAX_INPUT_TIME=${PHP_MAX_INPUT_TIME:-"300"}

# Configure php
{
  echo "# php settings:"
  echo "apc.shm_size        = $PHP_APC_SHM_SIZE"
  echo "apc.ttl             = $PHP_APC_TTL"
  echo "date.timezone       = $PHP_TIMEZONE"
  echo "max_execution_time  = $PHP_MAX_EXECUTION_TIME"
  echo "memory_limit        = $PHP_MEMORY_LIMIT"
  echo "post_max_size       = $PHP_POST_MAX_SIZE"
  echo "upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE"
  echo "max_file_uploads    = $PHP_MAX_FILE_UPLOADS"
  echo "max_input_time      = $PHP_MAX_INPUT_TIME"
} | tee $PHP_INI_DIR/conf.d/99-itop.ini

echo "** Executing '$@'"
exec "$@"