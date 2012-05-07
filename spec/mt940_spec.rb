require 'mt940'

describe MT940 do
  describe MT940::AccountIdentification do
    context 'account identifier' do
      it 'gives back the account identifier string' do
        acc_ident = MT940::AccountIdentification.new('some unused modifer','12345690')
        acc_ident.account_identifier.should == '12345690'
      end

      it 'only gets the first 35 characters' do
        content = '1' * 40
        acc_ident = MT940::AccountIdentification.new('some unused modifer', content)
        acc_ident.account_identifier.length.should == 35
      end
    end
  end
end
