#!/bin/bash

SOURCE_DIR="./bin"
TARGET_DIR="/usr/local/bin"
USER_NAME="$(whoami)"
GROUP_NAME="$(id -gn)"
SHELL_RC="$HOME/.zshrc "  # troque para .zshrc se usar zsh

echo "Criando links simbólicos e ajustando permissões..."

for file in "$SOURCE_DIR"/*; do
    filename=$(basename "$file")

    # Criação do link simbólico
    sudo ln -sf "$file" "$TARGET_DIR/$filename"
    sudo chown "$USER_NAME:$GROUP_NAME" "$TARGET_DIR/$filename"
    echo "✔️  Link criado: $TARGET_DIR/$filename -> $file"

    # Criação do alias se não existir
    if ! grep -q "alias $filename=" "$SHELL_RC"; then
        echo "alias $filename=\"$file\"" >> "$SHELL_RC"
        echo "🔗 Alias adicionado ao $SHELL_RC: $filename"
    else
        echo "⚠️  Alias '$filename' já existe em $SHELL_RC, pulando..."
    fi
done

echo ""
echo "✅ Todos os links e aliases foram processados."
echo "💡 Para aplicar os aliases imediatamente: source $SHELL_RC"
