require 'mt940'

describe MT940 do
  let(:file) { File.dirname(__FILE__) + "/fixtures/bph_sta.txt" }
  let(:messages) { MT940.parse(File.open(file,'r:ibm852').read) }
  let(:acc_id) { messages[0][1] }


  describe MT940::AccountIdentification do
    context 'account identifier' do
      it 'gives back the account identifier string' do
        acc_id.account_identifier.should == 'PL52106000760000321000055801'
      end
    end
  end

  describe MT940::StatementLine do
    let(:stline) { messages[0][8] }
    context 'amount'
    it 'parses the balance amount into a big decimal' do
      stline.amount.should be_a BigDecimal
      stline.amount.should == BigDecimal.new('1356.12')
    end
  end

  describe MT940::InformationToAccountOwner do
    let(:itoacc) { messages[0][9] }

    it 'gives back the narrative in lines' do
      itoacc.account_holder.should =~ /STACJA PALIW MIKO..AJCZYK ZA\nMKOWA 8 32-020 WIELICZKA/
      itoacc.account_identifier.should == "88106000760000321000095505"
      itoacc.transaction_description.should == "Przelew MultiCash"
      itoacc.details.should =~ /^ZAP..ATA ZA PALIWO.*/

    end
  end

  describe MT940::AccountBalance do

    let(:account_balance) { messages[0][3] }

    it 'parses the date of the balance from the 6 digits after the sign' do
      account_balance.date.should == Date.parse('2007-01-26')
    end

    it 'parses the currency of the balance' do
      account_balance.currency.should == 'PLN'
    end

    it 'parses the balance amount into a big decimal' do
      account_balance.amount.should be_a BigDecimal
      account_balance.amount.should == BigDecimal.new('45810300.95')
    end

  end
end
