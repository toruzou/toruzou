require 'spec_helper'

describe Organization do
  describe "validator" do
    describe "presence" do
      it "accepts valid instance." do
        organization = FactoryGirl.create(:organization)
        assert organization.valid?
      end

      it "contains no error message when abbreviation, 
          address, url or remarks is nil." do
        organization = FactoryGirl.create(:organization, address: nil, 
                                          url: nil, remarks: nil, 
                                          abbreviation: nil)
        assert organization.valid?
      end

      it "contains no error message when address, url or remarks is blank." do
        organization = FactoryGirl.create(:organization, address: "", 
                                          url: "", remarks: "", 
                                          abbreviation: "")
        assert organization.valid?
      end

      it "has errors when name is nil" do
        organization = FactoryGirl.build(:organization, 
                                          name: nil)
        assert organization.invalid?
        assert organization.errors[:name].any?
      end

      it "has errors when name is blank" do
        organization = FactoryGirl.build(:organization, 
                                          name: "")
        assert organization.invalid?
        assert organization.errors[:name].any?
      end
    end

    describe "length" do
      it "accepts 80 chars for name" do
        organization = FactoryGirl.build(:organization, 
                                          name: 'a' * 80)
        assert organization.valid?
      end

      it "doesn't accept 81 chars for name" do
        organization = FactoryGirl.build(:organization, 
                                          name: 'a' * 81)
        assert organization.invalid?
        assert organization.errors['name'].any?
      end

      it "accepts 20 chars for abbreviation" do
        organization = FactoryGirl.build(:organization, 
                                          abbreviation: 'a' * 20)
        assert organization.valid?
      end

      it "doesn't accept 21 chars for abbreviation" do
        organization = FactoryGirl.build(:organization, 
                                          abbreviation: 'a' * 21)
        assert organization.invalid?
        assert organization.errors['abbreviation'].any?
      end

      it "accepts 200 chars for address" do
        organization = FactoryGirl.build(:organization, 
                                          address: 'a' * 200)
        assert organization.valid?
      end

      it "doesn't accept 201 chars for address" do
        organization = FactoryGirl.build(:organization, 
                                          address: 'a' * 201)
        assert organization.invalid?
      end

      it "accepts 500 chars for remarks" do
        organization = FactoryGirl.build(:organization, 
                                          remarks: 'a' * 5000)
        assert organization.valid?
      end

      it "doesn't accept 501 chars for remarks" do
        organization = FactoryGirl.build(:organization, 
                                          remarks: 'a' * 5001)
        assert organization.invalid?
      end

      it "accepts 100 chars for url" do
        organization = FactoryGirl.build(:organization, 
                                          url: 'a' * 100)
        assert organization.valid?
      end

      it "doesn't accept 101 chars for url" do
        organization = FactoryGirl.build(:organization, 
                                          url: 'a' * 101)
        assert organization.invalid?
      end

    end
  end
end
