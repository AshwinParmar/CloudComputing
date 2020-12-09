provider "google" {
  credentials = file("CREDENTIALS_FILE.json")
  project     = "PROJECT-ID"
  region      = "europe-west3"  ## DE, Fr
}

### instance_id
resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default_vm" {
  name         = "tcs-vm-${random_id.instance_id.hex}"
  machine_type = "e2-standard-2" ## 2vCPU, 8GB RAM
  zone         = "europe-west3-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y dist-upgrade; sudo apt-get -y install nginx; sudo apt-get -y install php7.3-common; sudo apt-get -y install composer; sudo apt install tasksel; sudo apt install xrdp; sudo systemctl enable xrdp; sudo tasksel install lubuntu-desktop; sudo systemctl set-default graphical.target; create "

  network_interface {
    network = "default"

    access_config {

    }
  }

  #metadata {
  #  sshKeys = "dilanga:${file("id_rsa.pub")}"
  #}
}

resource "google_compute_firewall" "default" {
  name    = "nginx-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  allow {
    protocol = "icmp"
  }

}

output "ip" {
  value = "google_compute_instance.default_vm
  .network_interface.0.access_config.0.nat_ip"
}
