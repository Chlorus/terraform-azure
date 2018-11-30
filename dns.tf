resource "azurerm_dns_zone" "azure" {
  name = "azure.chlor.us"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  zone_type = "Public"
}

resource "azurerm_dns_a_record" "forest" {
  name = "forest"
  zone_name = "${azurerm_dns_zone.azure.name}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  ttl = 300
  records = ["${azurerm_public_ip.srcds.ip_address}"]
}