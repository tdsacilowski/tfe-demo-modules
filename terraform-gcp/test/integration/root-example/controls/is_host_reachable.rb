control 'is_host_reachable' do
  describe host(attribute('output_tfe_instance_public_ip'),
                port: 80,
                protocol: 'tcp') do
    it { should be_reachable }
  end
end
