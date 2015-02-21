require 'spec_helper'

describe 'moinmoin::wiki', :type => :define do
  let :pre_condition do
    'include moinmoin'
  end

  context 'default settings on a Debian system' do
    let(:facts) { { :osfamily => 'Debian' } }
    let(:title) { 'wiki' }
    let :params do
      {
        :sitename            => 'Wiki',
        :interwikiname       => 'Wiki',
        :data_dir            => '/srv/wiki/data/',
        :data_underlay_dir   => '/srv/wiki/underlay',
        :httpd_external_auth => false,
      }  
    end

    it { should contain_file('/etc/moin/wiki.py') }
    it { should contain_file('/srv/wiki/data/') }
    it { should contain_file('/srv/wiki/underlay/') }
  end
end
