#!/bin/bash
name="name"
email="e@mail.org"
passphrase="code"
expire_date="2026-01-01"  # Human-readable date in YYYY-MM-DD format
public_key_file="public_key.asc"

command="gpg --with-colons --fingerprint $email  2>&1| awk -F: '/^fpr:/ { print \$10 }'"
# echo $command
current_key=$(eval "$command")

# echo "key  - $current_key"

if [[ -z "$current_key" ]]; then
  echo "no key - creating" 
  expire_date=$(date -d "$expire_date" +%s)  # Convert to seconds since Unix epoch

    #there is no key - create it
  key_gen_command=$(gpg --batch --generate-key --pinentry-mode loopback --passphrase "" 2>&1 <<EOF
  Key-Type: RSA
  Key-Length: 3072
  Subkey-Type: RSA
  Subkey-Length: 3072
  Name-Real: $name
  Name-Email: $email
  Expire-Date: $expire_date
  Passphrase: $passphrase
  %commit
EOF
)
  # echo $key_gen_command
  current_key=$(echo "$key_gen_command" | grep -oP "key\s+\K\w+")
  if [[ -z "$current_key" ]]; then
    echo "error on key-gen:\n$key_gen_command"
    exit 1
  fi
else
# #get first of available
  read -r current_key <<< "$current_key"
fi

echo "key  - $current_key"

# echo "get key"

sign_command="./bsign --sign {{file}} -p $passphrase -P \"-u $current_key\" --force-resign"

path=$1

exit_status=0
# echo "path - $path"
if [ -d "$path" ]; then
  echo "$path is a directory. Sign all files there."
  find "$path" -type f -exec file {} \; | while IFS=: read -r file output; do
    if [[ $output == *ELF* ]]; then
        echo "\nProcessing file: $file"
        # Escaping whitespaces in the path and filename
        escaped_filename="${file// /\\ }"
        # echo $escaped_filename
        escaped_filename="${escaped_filename//(/\\(}"
        escaped_filename="${escaped_filename//)/\\)}"
        sign_command="${sign_command//\{\{file\}\}/$escaped_filename}"
        # echo $sign_command
        eval $sign_command
        exit_status+=$?
    fi
done
elif [ -f "$path" ]; then
  # echo "$path is a file"
  escaped_filename="${path// /\\ }"
  # echo $escaped_filename
  escaped_filename="${escaped_filename//(/\\(}"
  escaped_filename="${escaped_filename//)/\\)}"
  sign_command="${sign_command//\{\{file\}\}/$escaped_filename}"
  echo $sign_command
  eval $sign_command
  exit_status+=$?
else
  echo "$path does not exist or is neither a file nor a directory."
fi

# echo $exit_status 
if [ "$exit_status" -ne 0 ]; then
  echo "there were some errors"
fi

gpg --yes --export --armor "$email" > "$public_key_file"
