require 'spec_helper'

describe Api::V1::PeopleController do
  before(:each) do
    login_user
  end

  before(:all) do
    @bank1 = valid_organization
    @bank2 = valid_organization

    @person1 = valid_person(@bank1.id)
    @person1.name  = "Ichibanme"
    @person1.phone = "0120-44-4444"
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

  describe "GET api/v1/people" do
    it "shows all people registered." do
      get :index, page: 1

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(3)

      entries = JSON.parse(body)[1]
      ids = [ entries[0]['id'], entries[1]['id'], entries[2]['id'] ]
      assert ids.include?(@person1.id)
      assert ids.include?(@person2.id)
      assert ids.include?(@person3.id)
    end

    it "shows people belongs to designated organization id." do
      get :index, organization_id: @bank2.id, page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person2.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end

    it "shows people belongs to designated organization." do
      get :index, organization_name: @bank2.name, page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person2.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end

    it "shows people belongs to designated name (case non sensitive)." do
      get :index, name: "iChi", page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person1.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end

    it "shows people belongs to designated phone." do
      get :index, phone: "3278", page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(2)
      ids = [ JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id'] ]
      assert ids.include?(@person2.id)
      assert ids.include?(@person3.id)
      expect(JSON.parse(body)[1][2]).to eq(nil)
    end

    it "shows people belongs to designated email (case non sensitive)." do
      get :index, email: "EXaMP", page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(2)
      ids = [ JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id'] ]
      assert ids.include?(@person1.id)
      assert ids.include?(@person2.id)
      expect(JSON.parse(body)[1][2]).to eq(nil)
    end

    it "shows people designated by multiple conditions." do
      get :index, phone: '3278', email: 'second', page: 1

      expect(JSON.parse(body)[0]['total_entries']).to eq(1)
      expect(JSON.parse(body)[1][0]['id']).to eq(@person2.id)
      expect(JSON.parse(body)[1][1]).to eq(nil)
    end
  end

  describe "GET api/v1/people/1" do
    it "shows designated person when given id is valid." do
      get :show, id: @person1.id, page: 1

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@person1.id)
      expect(JSON.parse(body)['name']).to eq(@person1.name)
    end

    it "returns 404 when record for given id doesn't exist" do
      get :show, id: @person3.id + 100, page: 1
      expect(status).to eq(404)
      expect(body).to eq(" ")
    end
  end

  describe "POST api/v1/people" do
    it "is able to create new record." do
      param = { name: 'sample john', address: 'dummy address',
                remarks: 'sample remarks' }
      post :create, person: param

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).not_to be_nil
      expect(JSON.parse(body)['name']).to eq('sample john')
      expect(JSON.parse(body)['address']).to eq('dummy address')
      expect(JSON.parse(body)['remarks']).to eq('sample remarks')
    end

    it "is unable to create new record with invalid parameter" do
      param = { name: '', address: 'dummy address',
                remarks: 'sample remarks' }
      post :create, person: param

      expect(status).to eq(422)
    end
  end

  describe "PUT api/v1/people/1" do
    it "is able to update existing record." do
      id = @person1.id
      name = @person1.name

      get :show, id: id, page: 1
      expect(JSON.parse(body)['name']).to eq(name)

      put :update, id: id, person: { name: "updated name" }

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(id)
      expect(JSON.parse(body)['name']).to eq("updated name")
    end
    
    it "is unable to update existing record with invalid param." do
      id = @person1.id
      name = @person1.name

      get :show, id: id, page: 1
      expect(JSON.parse(body)['name']).to eq(name)

      put :update, id: id, person: { name: "" }

      expect(status).to eq(422)
      expect(body).to eq(JSON.generate(
        { name: [
            "can't be blank"
          ] 
        }
      ))
    end
  end

  describe "DELETE api/v1/people/1" do
    it "is able to delete existing record" do
      @to_delete = FactoryGirl.create(:person)
      id = @to_delete.id

      get :show, id: id, page: 1
      expect(status).to eq(200)

      delete :destroy, id: id
      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(id)

      get :show, id: id, page: 1
      expect(status).to eq(404)
    end
  end

  describe "People API under Organization" do
    describe "GET api/v1/organizations/1/people" do
      it "shows people which belongs to organization #1." do
        @bank1 = valid_organization
        @bank2 = valid_organization

        @person1 = valid_person(@bank1.id)
        @person2 = valid_person(@bank2.id)

        get :index, organization_id: @bank1.id, page: 1

        expect(status).to eq(200)

        expect(JSON.parse(body)[0]['total_entries']).to eq(1)
        expect(JSON.parse(body)[1][0]['id']).to eq(@person1.id)
      end
    end

    describe "GET api/v1/organization/1/people/1" do
      it "shows person which belongs to organization." do
        get :show, organization_id: @bank1.id, id: @person1.id, page: 1

        expect(status).to eq(200)
        expect(JSON.parse(body)['id']).to eq(@person1.id)
      end

      it "returns 404 when person doesn't belong to organization." do
        get :show, organization_id: @bank2.id, id: @person1.id, page: 1

        expect(status).to eq(404)
        expect(body).to eq(" ")
      end
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
