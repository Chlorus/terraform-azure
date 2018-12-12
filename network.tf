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
  name = "srcds"
  address_prefix = "10.0.1.0/24"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  virtual_network_name ="${azurerm_virtual_network.gaming.name}"
  network_security_group_id = "${azurerm_network_security_group.srcdsrules.id}"
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
    public_ip_address_id = "${azurerm_public_ip.srcds.id}"
  }
}

resource "azurerm_public_ip" "srcds" {
  name = "srcds-ip"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  public_ip_address_allocation = "static"

  tags {
    environment = "Dev"
  }
}

resource "azurerm_network_security_group" "srcdsrules" {
  name = "SRCDS-Access"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"

  security_rule {
    name = "RDPTCP"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "73.217.104.49/32"
    destination_address_prefix  = "*"
  }

  security_rule {
    name = "RDPUDP"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "73.217.104.49/32"
    destination_address_prefix  = "*"
  }

  security_rule { 
    name = "SRCDSUdp"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    destination_port_range = "27015"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

    security_rule { 
    name = "SRCDSTcp"
    priority = 201
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "27015"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule { 
    name = "SRCTV"
    priority = 202
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    source_address_prefix = "*"
    destination_port_range = "27020"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule { 
    name = "SRCClient"
    priority = 203
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    destination_port_range = "27005"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule {
    name = "TheForestTcp0"
    priority = 300
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "8766"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule {
    name = "TheForestUdp0"
    priority = 301
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    destination_port_range = "8766"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule {
    name = "TheForestTcp1"
    priority = 302
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "27016"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }

  security_rule {
    name = "TheForestUdp1"
    priority = 303
    direction = "Inbound"
    access = "Allow"
    protocol = "Udp"
    source_port_range = "*"
    destination_port_range = "27016"
    destination_address_prefix  = "*"
    source_address_prefix  = "*"
  }
  
}