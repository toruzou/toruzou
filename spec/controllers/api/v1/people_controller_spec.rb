require 'spec_helper'

describe Api::V1::PeopleController do
  before(:each) do
    login_user
  end

  describe "GET api/v1/people" do
    before(:all) do
      @bank1 = valid_organization
      @bank2 = valid_organization

      @person1 = valid_person(@bank1.id)
      @person1.name  = "Ichibanme"
      @person1.phone = "0120-444-444"
      @person1.email = "first@example.com"
      @person1.save

      @person2 = valid_person(@bank2.id)
      @person2.name  = "Nibanme"
      @person2.phone = "03-3278-6768"
      @person2.email = "second@example.com"
      @person2.save
      
      @person3 = valid_person(@bank1.id)
      @person3.name  = "Sanbanme"
      @person3.phone = "03-3278-6768"
      @person3.email = "third@dummy.com"
      @person3.save
    end

    after(:all) do
      @bank1.destroy
      @bank2.destroy

      @person1.destroy
      @person2.destroy
      @person3.destroy
    end

    it "shows all people registered." do
      get :index

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(3)

      entries = JSON.parse(body)[1]
      ids = [ entries[0]['id'], entries[1]['id'], entries[2]['id'] ]
      assert ids.include?(@person1.id)
      assert ids.include?(@person2.id)
      assert ids.include?(@person3.id)
    end

    it "shows people belongs to designated organization." do
      get :index, organization_id: @bank2.id

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person2.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end

    it "shows people belongs to designated name (case non sensitive)." do
      get :index, name: "iChi"

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person1.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end

    it "shows people belongs to designated phone." do
      get :index, phone: "3278"

      expect(JSON.parse(body)[0]['total_entries']).to eq(2)
      ids = [ JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id'] ]
      assert ids.include?(@person2.id)
      assert ids.include?(@person3.id)
      expect(JSON.parse(body)[1][2]).to eq(nil)
    end

    it "shows people belongs to designated email (case non sensitive)." do
      get :index, email: "EXaMP"

      expect(JSON.parse(body)[0]['total_entries']).to eq(2)
      ids = [ JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id'] ]
      assert ids.include?(@person1.id)
      assert ids.include?(@person2.id)
      expect(JSON.parse(body)[1][2]).to eq(nil)
    end

    it "shows people designated by multiple conditions." do
      get :index, phone: '3278', email: 'second'

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person2.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end
  end

  describe "GET api/v1/organizations/1/people" do
    it "shows people which belongs to organization #1." do
      @organization1 = valid_organization
      @organization2 = valid_organization

      @person1 = valid_person(@organization1.id)
      @person2 = valid_person(@organization2.id)

      get :index, organization_id: @organization1.id

      expect(status).to eq(200)

      expect(JSON.parse(body)[0]).to eq({"total_entries" =>  1})
      expect(JSON.parse(body)[1][0]['id']).to eq(@person1.id)
    end
  end

  describe "GET api/v1/organization/1/people/1" do
    before(:all) do
      @organization1 = valid_organization
      @organization2 = valid_organization

      @person1 = valid_person(@organization1.id)
    end

    after(:all) do
      @organization1.destroy
      @organization2.destroy

      @person1.destroy
    end

    it "shows person which belongs to organization." do
      get :show, organization_id: @organization1.id, id: @person1.id

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@person1.id)
    end

    it "returns 404 when person doesn't belong to organization." do
      get :show, organization_id: @organization2.id, id: @person1.id

      expect(status).to eq(404)
      expect(body).to eq(" ")
    end
  end

  private 
  def valid_organization
    FactoryGirl.create(:organization)
  end
  
  def valid_person(id)
    FactoryGirl.create(:person, organization_id: id)
  end
end
