require 'spec_helper'

describe 'moinmoin::wiki', :type => :define do
  let :pre_condition do
    'include moinmoin'
  end

  context 'example settings on a Debian system' do
    let(:facts) { { :osfamily => 'Debian' } }
    let(:title) { 'wiki' }
    let :params do
      {
        :sitename            => 'Wiki',
        :interwikiname       => 'Wiki',
        :data_dir            => '/srv/wiki/data/',
        :data_underlay_dir   => '/srv/wiki/underlay/',
        :httpd_external_auth => false,
      }  
    end

    it { should contain_class('moinmoin::params') }

    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    sitename = u'Wiki' # \[Unicode\]$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    interwikiname = u'Wiki' # \[Unicode\]$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    data_dir = '\/srv\/wiki\/data\/'$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    data_underlay_dir = '\/srv\/wiki\/underlay\/'$/)
    end
    it { should contain_file('/srv/wiki/data/') }
    it { should contain_file('/srv/wiki/underlay/') }
    
    context 'invalid httpd_external_auth setting' do
      let :params do
        super().merge({
          :httpd_external_auth => 'test'
        })
      end

      it do
        expect {
          should contain_file('/etc/moin/wiki.py')
        }.to raise_error(Puppet::Error, /\"test\" is not a boolean/)
      end
    end

    context 'httpd_external_auth => true' do
      let :params do
        super().merge({
          :httpd_external_auth => true
        })
      end

      it do
        should contain_file('/etc/moin/wiki.py') \
          .with_content(/^    from MoinMoin.auth import GivenAuth$/)
          .with_content(/^    auth = \[GivenAuth\(autocreate=True\)\]$/)
      end
    end
  end
  
  context 'example settings on a Red Hat system' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let(:title) { 'wiki' }
    let :params do
      {
        :sitename            => 'Wiki',
        :interwikiname       => 'Wiki',
        :data_dir            => '/srv/wiki/data/',
        :data_underlay_dir   => '/srv/wiki/underlay/',
        :httpd_external_auth => false,
      }  
    end

    it { should compile }
    it { should contain_class('moinmoin::params') }

    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    sitename = u'Wiki' # \[Unicode\]$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    interwikiname = u'Wiki' # \[Unicode\]$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    data_dir = '\/srv\/wiki\/data\/'$/)
    end
    it do
      should contain_file('/etc/moin/wiki.py') \
        .with_content(/^    data_underlay_dir = '\/srv\/wiki\/underlay\/'$/)
    end

    it { should contain_file('/srv/wiki/data/') }
    it { should contain_file('/srv/wiki/underlay/') }
  end

  context 'example settings on a Solaris system' do
    let(:facts) { { :osfamily => 'Solaris' } }
    let(:title) { 'wiki' }
    let :params do
      {
        :sitename            => 'Wiki',
        :interwikiname       => 'Wiki',
        :data_dir            => '/srv/wiki/data/',
        :data_underlay_dir   => '/srv/wiki/underlay/',
        :httpd_external_auth => false,
      }  
    end

    it do
      expect {
        should compile
      }.to raise_error(/Solaris is not supported./)
    end
  end
end
