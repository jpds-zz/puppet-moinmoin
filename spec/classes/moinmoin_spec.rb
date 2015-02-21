require 'spec_helper'

describe 'moinmoin', :type => 'class' do

  context "On a Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_package('python-moinmoin') }
    it { should contain_file('/etc/moin').with_path('/etc/moin') }
    it {
      should contain_file('/etc/moin/farmconfig.py').with_path('/etc/moin/farmconfig.py')
    }
  end

  context "On an unknown OS" do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

end
