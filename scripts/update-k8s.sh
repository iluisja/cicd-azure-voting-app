#!/bin/bash

set -x

echo "Luigui $1 $2 $3"

if [ -d "/tmp/temp_repo" ]; then
    echo "El directorio /tmp/temp_repo existe. Se eliminará."
    # Elimina el directorio
    rm -rf "/tmp/temp_repo"
    echo "El directorio /tmp/temp_repo ha sido eliminado."
else
    echo "El directorio /tmp/temp_repo no existe."
fi

echo "Luigui 2"

# Set the repository URL
REPO_URL="https://wteioaupjyy7jxx6an5zxfzphp5ygiydzsraiwegqrumqiat6rua@dev.azure.com/0619627002/votingappdevops/_git/votingappdevops"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

if [ $? -ne 0 ]; then
    echo "Error al clonar el repositorio. Verifica la URL y los permisos."
    exit 1
fi

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: votingappdevops/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory