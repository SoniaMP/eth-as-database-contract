
RPC_URL=http://localhost:8545

echo "⚡ Script interactivo para tu contrato Solidity"
read -p "👉 Introduce la dirección del contrato: " CONTRACT_ADDRESS
read -p "🔑 Introduce tu clave privada: " PRIVATE_KEY

while true; do
  echo ""
  echo "===== MENÚ ====="
  echo "1) Listar compañías"
  echo "2) Registrar compañía"
  echo "3) Cambiar clave privada"
  echo "4) Salir"
  echo "================"
  read -p "Elige una opción: " OPTION

  case $OPTION in
    1)
      echo "📡 Llamando a getCompanies..."
      cast call $CONTRACT_ADDRESS \
        "getCompanies()(string[])" \
        --private-key $PRIVATE_KEY \
        --rpc-url $RPC_URL
      ;;
    2)
      read -p "Introduce el VAT de la compañía: " VAT
      echo "✍️ Registrando compañía con VAT: $VAT ..."
      cast send $CONTRACT_ADDRESS \
        "registerCompany(string)" "$VAT" \
        --private-key $PRIVATE_KEY \
        --rpc-url $RPC_URL
      ;;
    3) read -p "Introduce tu nueva clave privada: " NEW_PRIVATE_KEY
      PRIVATE_KEY=$NEW_PRIVATE_KEY
      ;;
    4)
      echo "👋 Saliendo..."
      exit 0
      ;;
    *)
      echo "❌ Opción no válida"
      ;;
  esac
done