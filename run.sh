#!/bin/bash

SOURCE_DIR="$(pwd)/bin"
TARGET_DIR="/usr/local/bin"
USER_NAME="$(whoami)"
GROUP_NAME="$(id -gn)"
SHELL_RC="$HOME/.zshrc"  # ou .bashrc, se for o caso

echo "📁 Copiando arquivos para $TARGET_DIR e ajustando permissões..."

for file in "$SOURCE_DIR"/*; do
    filename=$(basename "$file")
    target_path="$TARGET_DIR/$filename"

    # Copiar o arquivo
    sudo cp -f "$file" "$target_path"
    sudo chown "$USER_NAME:$GROUP_NAME" "$target_path"
    sudo chmod +x "$target_path"  # garantir que seja executável
    echo "✔️  Copiado: $file -> $target_path"

    # Alias apontando para o binário copiado
    if ! grep -q "alias $filename=" "$SHELL_RC"; then
        echo "alias $filename=\"$target_path\"" >> "$SHELL_RC"
        echo "🔗 Alias adicionado ao $SHELL_RC: $filename -> $target_path"
    else
        echo "⚠️  Alias '$filename' já existe em $SHELL_RC, pulando..."
    fi
done

echo ""
echo "✅ Todos os arquivos foram copiados e os aliases criados."
echo "💡 Para aplicar os aliases imediatamente: source $SHELL_RC"
