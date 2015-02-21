require 'spec_helper'

describe 'moinmoin', :type => 'class' do

  context "On a Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it { should contain_package('python-moinmoin') \
      .that_comes_before('File[/etc/moin]') }
    it { should contain_file('/etc/moin').with_path('/etc/moin') }
    it {
      should contain_file('/etc/moin/farmconfig.py').with(
        'ensure' => 'file',
        'path'   => '/etc/moin/farmconfig.py',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
      )
    }

    context 'with wikis configured' do
      let :params do
        {
          :wikis => {
            'wiki'      => 'https://wiki.prod/',
            'wiki-test' => 'https://wiki.test/'
          }
        }
      end
      it {
        should contain_file('/etc/moin/farmconfig.py') \
          .with_content(/^      \(\"wiki\", r\"https:\/\/wiki\.prod\/\"\),$/) \
          .with_content(/^      \(\"wiki-test\", r\"https:\/\/wiki\.test\/\"\),$/)
      }
    end
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
