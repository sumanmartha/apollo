resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  metadata = {
    ssh-keys = "ubuntu:${file("TestKeyPair.pub")}"
  }

  tags = ["test-webserver"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }
  
  network_interface {
    # A default network is created for all GCP projects
    network       = google_compute_network.default.name
    access_config {
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 180;
	  >test_website.ini;
	  echo "[test_website]" | tee -a test_website.ini;
	  echo "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} ansible_ssh_private_key_file=${var.private_key} ansible_user=${var.ansible_user}" | tee -a test_website.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  #ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i test_website.ini playbooks/install_webserver.yaml
    ansible-playbook -i test_website.ini playbooks/install_webserver.yaml

EOT

  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["198.144.216.128/32", "124.123.169.253/32", "104.56.114.248/32", "102.129.121.173/32", "192.195.81.38/32"]

  source_tags = ["test-webserver"]
}

resource "google_compute_network" "default" {
  name = "test-network1"
}

