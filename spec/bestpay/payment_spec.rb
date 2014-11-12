require 'spec_helper'
require 'digest/md5'

module Bestpay
  module Payment
    describe Web do
      let(:web_params) {
        {
          "MERCHANTID"  => '0018888888',  
          "ORDERSEQ"    => '111',
          "ORDERDATE"   => '20141112131313',
          "ORDERAMOUNT" => '222',
          "KEY"         => 'G7AXS7874305BV59',
          'ORDERREQTRANSEQ' => '111',
          'PRODUCTAMOUNT' => '111',
          'ATTACHAMOUNT' => '111',
          'ATTACH' => '111',
          'TMNUM' => '111',
          'PRODUCTDESC' => '111',
          #'CLIENTIP' => '111',
        }
      }

      it '#payment_url' do
        expect(Web.payment_url(web_params)).to be_a_kind_of String
      end

      it "#direct_payment_url"

      it "#unify_payment_url"


    end

    describe Wap do
      let(:web_params) {
        {
          "MERCHANTID"  => '0018888888',  
          "ORDERSEQ"    => '112',
          "ORDERDATE"   => '20141112131313',
          "ORDERAMOUNT" => '2.00',
          "KEY"         => 'G7AXS7874305BV59',
          'ORDERREQTRANSEQ' => '111',
          'PRODUCTAMOUNT' => '1.00',
          'ATTACHAMOUNT' => '1.00',
          'ATTACH' => '111',
          'TMNUM' => '1',
          'CUSTOMERID' => 'Leo',
          'PRODUCTDESC' => '111',
          #'CLIENTIP' => '111',
        }
      }

      it '#payment_url' do
        expect(Wap.payment_url(web_params)).to be_a_kind_of String
      end

      it "#direct_payment_url"
    end

  end
end

