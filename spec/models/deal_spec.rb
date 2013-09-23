require 'spec_helper'

describe Deal do
  describe "validation" do
    describe "mandatory field" do

      it "accepts valid fields." do
        entity = FactoryGirl.build(:deal)
        assert entity.valid?
      end

      it "doesn't accept if name is empty." do
        entity = FactoryGirl.build(:deal, name: "")
        assert entity.invalid?
      end

      it "doesn't accept if name is nil." do
        entity = FactoryGirl.build(:deal, name: nil)
        assert entity.invalid?
      end
    end

    describe "status" do

      it "accepts empty." do
        entity = FactoryGirl.build(:deal, status: "")
        assert entity.valid?
      end

      it "accepts nil." do
        entity = FactoryGirl.build(:deal, status: nil)
        assert entity.valid?
      end

      it "accepts 'Plan', 'Proposal', 'In Negotiation', 'Won' and 'Lost'." do
        ['Plan', 'Proposal', 'In Negotiation', 'Won' ,'Lost'].each { |status|
          entity = FactoryGirl.build(:deal, status: status)
          assert entity.valid?, status + " is expected valid, but isn't."
        }
      end

      it "doesn't accept other value." do
        entity = FactoryGirl.build(:deal, status: 'Fighting')
        assert entity.invalid?
      end

    end

    describe "accuracy" do
      it "accepts nil." do
        entity = FactoryGirl.build(:deal, accuracy: nil)
        assert entity.valid?
      end

      it "accepts 0, 25, 50, 75, 90 and 100." do
        [0, 25, 50, 75, 90, 100].each { |accuracy|
          entity = FactoryGirl.build(:deal, accuracy: accuracy)
          assert entity.valid?, accuracy.to_s + " is expected valid, but isn't."
        }
      end

      it "doesn't accept other value." do
        entity = FactoryGirl.build(:deal, accuracy: 105)
        assert entity.invalid?
      end
    end

    describe "amount" do

      it "allows 100000000000 (10e11)." do
        entity = FactoryGirl.build(:deal, amount: 10 ** 11)
        assert entity.valid?
      end

      it "doesn't allows 100000000001." do
        entity = FactoryGirl.build(:deal, amount: 10 ** 11 + 1)
        assert entity.invalid?
      end
      
      it "allows 0." do
        entity = FactoryGirl.build(:deal, amount: 0)
        assert entity.valid?
      end

      it "doesn't allow negative value." do
        entity = FactoryGirl.build(:deal, amount: -1)
        assert entity.invalid?
      end

    end
    
  end
end
