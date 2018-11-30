resource "azurerm_virtual_network" "gaming" {
  name = "srcds-network"
  address_space = ["10.0.0.0/16"]
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"

      tags { 
        environment = "Dev"
    }
}

resource "azurerm_subnet" "srcds" {
  name = "Source Dedicated Servers"
  address_prefix = "10.0.1.0/24"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  virtual_network_name ="${azurerm_virtual_network.gaming.name}"
}

resource "azurerm_subnet_network_security_group_association" "srcds" {
  subnet_id = "${azurerm_subnet.srcds.id}"
  network_security_group_id = "${azurerm_network_security_group.srcdsrules.id}"

}

resource "azurerm_network_interface" "srcds" {
  name ="srcds-nic"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"

  ip_configuration {
    name ="srcdsipconfig"
    subnet_id = "${azurerm_subnet.srcds.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_public_ip" "srcds" {
  name = "Source Dedicated Server Public IP"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  public_ip_address_allocation = "static"

  tags {
    environment = "Dev"
  }
}

resource "azurerm_network_security_group" "srcdsrules" {
  name = "RDP Access"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"

  security_rule {
    name = "RDPTCP"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    destination_port_range = "3389"
    source_address_prefix = "73.217.104.49/32"
  }

  security_rule {
    name = "RDPUDP"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "3389"
    source_address_prefix = "73.217.104.49/32"
  }

  security_rule { 
    name = "SRCDS"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "27015"
  }

    security_rule { 
    name = "SRCDS"
    priority = 201
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    destination_port_range = "27015"
  }

  security_rule { 
    name = "SRCTV"
    priority = 202
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "27020"
  }

  security_rule { 
    name = "SRCClient"
    priority = 203
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "27005"
  }

  security_rule {
    name = "TheForestTcp"
    priority = 300
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    destination_port_range = "8766"
  }

  security_rule {
    name = "TheForestUdp"
    priority = 301
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "8766"
  }

  security_rule {
    name = "TheForestTcp"
    priority = 302
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    destination_port_range = "27016"
  }

  security_rule {
    name = "TheForestUdp"
    priority = 303
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    destination_port_range = "27016"
  }
  
}