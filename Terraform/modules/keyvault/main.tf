# Create a Key Vault - Currently to store Private SSH Key for Bastion Host 

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
}



# Once Key Vault created, use this AZ CLI command to set a secret (Private SSH Key for Bastion Host)
# az keyvault secret set --vault-name <key_vault_name> --name <secret_name> --value <secret_value>
# Example:
    # az keyvault secret set --vault-name kv-lewis-secure --name ssh-private-key --file ~/.ssh/id_rsa

# Once deployed, you can retrieve the secret using this command:
# az keyvault secret show --name ssh-private-key --vault-name kv-lewis-secure
# Example:
    # az keyvault secret show --vault-name kv-lewis-secure --name ssh-private-key



