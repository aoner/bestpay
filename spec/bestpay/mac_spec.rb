require 'spec_helper'
require 'digest/md5'

module Bestpay
  describe Mac do
    let(:web_params) {
      {
        "MERCHANTID"  => '111',  
        "ORDERSEQ"    => '111',
        "ORDERDATE"   => '111',
        "ORDERAMOUNT" => '111',
        "KEY"         => '111'
      }
    }

    let(:web_params_with_client_ip) {
      params = web_params.clone
      params['CLIENTIP'] = '127.0.0.1'
      params
    }

    let(:web_mac) {
        Digest::MD5.hexdigest('MERCHANTID=111&ORDERSEQ=111&ORDERDATE=111&ORDERAMOUNT=111&KEY=111').upcase
    }

    let(:web_mac_with_client_ip) {
        Digest::MD5.hexdigest('MERCHANTID=111&ORDERSEQ=111&ORDERDATE=111&ORDERAMOUNT=111&CLIENTIP=127.0.0.1&KEY=111').upcase
    }

    let(:wap_params) {
    }


    it "#build_mac" do
      expect(Mac.build_mac(web_params)).to eq web_mac
    end

    it "#build_mac with client ip" do
      expect(Mac.build_mac(web_params_with_client_ip)).to eq web_mac_with_client_ip
    end

    it "#valid?" do
      expect( Mac.valid?( web_params.merge( 'MAC' => web_mac ) ) ).to be true
      expect( Mac.valid?( web_params.merge( 'MAC' => 'hi,all' ) ) ).to be false
      #expect( Mac.valid?( web_params_with_client_ip.merge( 'mac' => web_mac_with_client_ip ) ) ).to be true
      #expect( Mac.valid?( web_params_with_client_ip.merge( 'mac' => 'hi,all' ) ) ).to be false
    end
  end
end
