module Bestpay
  module Notify
    describe Web do
      let(:web_params) {
        {
          'UPTRANSEQ' => '111',
          'MERCHANTID' => '111',
          'ORDERID' => '111',
          'PAYMENT' => '111',
          'RETNCODE' => '0000',
          'RETNINFO' => '111',
          'PAYDATE' => '111',
          'SIGN' => Digest::MD5.hexdigest('UPTRANSEQ=111&MERCHANTID=111&ORDERID=111&PAYMENT=111&RETNCODE=0000&RETNINFO=111&PAYDATE=111&KEY=1D2EF3AED4ERHJ5WER6').upcase
        }
      }
      let(:key) {'1D2EF3AED4ERHJ5WER6'}
      it "#valid?" do
        expect(Web.valid?(web_params, key)).to be true
      end

      it '#successful?' do
        expect(Web.successful?(web_params, key)).to be true
      end
    end

    describe Wap do
      it "#valid" do
        #Wap.valid?(wap_params, key)
      end
    end
  end
end
