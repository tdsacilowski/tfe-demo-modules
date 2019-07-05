control 'operating_system' do
  describe command('cat /etc/*release') do
    its('stdout') { should match (/CentOS/) }
  end
end