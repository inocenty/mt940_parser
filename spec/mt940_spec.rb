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

  describe MT940::InformationToAccountOwner do
    it 'gives back the narrative in lines' do
      content = 'NAME ACCOUNT OWNER: FEANDO LIMITED
                 ACCOUNT DESCRIPTION: CURR'

      info = MT940::InformationToAccountOwner.new('some unsed modifier', content)

      info.narrative.should == ['NAME ACCOUNT OWNER: FEANDO LIMITED',
                                'ACCOUNT DESCRIPTION: CURR']
    end
  end

  describe MT940::StatementNumber do
    let(:content) { '01704/01234' }

    subject { MT940::StatementNumber.new('some unused modifier', content) }

    it 'gives back the number of the statement as a string' do
      subject.number.should == '01704'
    end

    it 'gives back the sequence number of the statement' do
      subject.sequence.should == '01234'
    end

    it 'gives back nil if the sequence number is not included' do
      statement_number = MT940::StatementNumber.new('some unused modifier', '01704')
      statement_number.sequence.should be_nil
    end

  end
end
