control 'gcp_compute_instance_exists' do
  describe google_compute_instance(project: attribute('input_gcp_project'),
                                   zone: attribute('input_tfe_instance_zone'),
                                   name: attribute('input_tfe_instance_name')) do
    its('status') { should eq 'RUNNING' }

    its('first_network_interface_nat_ip_exists') { should be true }
    its('first_network_interface_name') { should eq 'external-nat' }
    its('first_network_interface_type') { should eq 'one_to_one_nat' }
  end
end
