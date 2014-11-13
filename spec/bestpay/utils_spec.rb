require 'spec_helper'
require 'digest/md5'

PAYMENT_KEYS = %w{MERCHANTID ORDERSEQ ORDERDATE ORDERAMOUNT CLIENTIP KEY}
NOTIFY_KEYS = %w{UPTRANSEQ MERCHANTID ORDERID PAYMENT RETNCODE RETNINFO PAYDATE KEY}

module Bestpay
  describe Utils do
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


    let(:notify_params) {
      {
      'UPTRANSEQ'=>'20080101000001',
      'MERCHANTID'=>'0250000001',
      'ORDERID'=>'2006050112564931556',
      'PAYMENT'=>'10000',
      'RETNCODE'=>'0000',
      'RETNINFO'=>'0000',
      'PAYDATE'=>'20060101',
      'KEY'=>'1A2WE3EV4SD5W6FEF4AE',
      }
    }

    let(:notify_mac) {
      Digest::MD5.hexdigest('UPTRANSEQ=20080101000001&MERCHANTID=0250000001&ORDERID=2006050112564931556&PAYMENT=10000&RETNCODE=0000&RETNINFO=0000&PAYDATE=20060101&KEY=1A2WE3EV4SD5W6FEF4AE').upcase
    }

    it "#build_for_payment" do
      expect(Utils.build_mac(web_params, PAYMENT_KEYS)).to eq web_mac
    end

    it "#build_for_payment with client ip" do
      expect(Utils.build_mac(web_params_with_client_ip, PAYMENT_KEYS)).to eq web_mac_with_client_ip
    end

    #it "#payment_valid?" do
      #expect( Utils.payment_valid?( web_params.merge( 'MAC' => web_mac ) ) ).to be true
      #expect( Utils.payment_valid?( web_params.merge( 'MAC' => 'hi,all' ) ) ).to be false
    #end

    #it "#notify_valid?" do
      #expect( Utils.notify_valid?( notify_params.merge('MAC'=>notify_mac) )).to be true
    #end
  end
end
