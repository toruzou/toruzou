require 'spec_helper'

describe Api::V1::DealsController do

  before(:each) do
    login_user
  end

  before(:all) do
    @special_user = FactoryGirl.create(:user, email: 'special@example.com')

    @deal1 = FactoryGirl.create(:deal, name: 'First Deal', status: 'Plan')
    @deal2 = FactoryGirl.create(:deal, name: 'Second Deal', status: 'Proposal',
                                organization_id: @deal1.organization_id,
                                sales_id: @special_user.id,
                                pm_id: @deal1.pm_id)
    @deal3 = FactoryGirl.create(:deal, name: 'Third Deal', status: 'Won',
                                sales_id: @deal1.sales_id, 
                                pm_id: @special_user.id,
                                contact_id: @deal1.contact_id)
  end

  after(:all) do
    [@deal1, @deal2, @deal3].each { |deal|
      deal.organization.destroy if deal.organization
      deal.pm.destroy if deal.pm
      deal.sales.destroy if deal.sales
      deal.contact.destroy if deal.contact
      deal.destroy
    }

  end

  describe "GET api/v1/deals" do
    it "shows all people registered." do
      get :index

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(3)

      entries = JSON.parse(body)[1]
      ids = [ entries[0]['id'], entries[1]['id'], entries[2]['id'] ]
      assert ids.include?(@deal1.id)
      assert ids.include?(@deal2.id)
      assert ids.include?(@deal3.id)
    end

    it "shows deals belonging to organization designated by id." do
      get :index, organization_id: @deal1.organization.id

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal2.id)
    end

    it "shows deals belonging to organization designated by name." do
      get :index, organization_name: @deal3.organization.name

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(1)

      expect(JSON.parse(body)[1][0]['id']).to eq(@deal3.id)
    end

    it "shows deals which have designated name." do
      get :index, name: 'Ir'

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal3.id)
    end

    it "shows deals whose pm is designated by name." do
      get :index, pm_name: @deal1.pm.name

      expect(status).to eq(200)
      expect(body).to have_json_size(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal2.id)
    end

    it "shows deals whose sales is designated by name." do
      get :index, sales_name: @deal1.sales.name

      expect(status).to eq(200)
      expect(body).to have_json_size(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal3.id)
    end

    it "shows deals whose pm or sales is designated by id." do
      get :index, user_id: @special_user.id

      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal2.id)
      assert entries.include?(@deal3.id)

    end

    it "shows deals whose contact is designated by name." do
      get :index, contact_name: @deal1.contact.name

      expect(status).to eq(200)
      expect(body).to have_json_size(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal3.id)
    end

    describe "showing deals whose status is designated" do
      it "single status." do
        get :index, statuses: ['Won']

        expect(status).to eq(200)
        expect(body).to have_json_size(2)
        expect(JSON.parse(body)[0]['total_entries']).to eq(1)

        expect(JSON.parse(body)[1][0]['id']).to eq(@deal3.id)
      end

      it "multiple status." do
        get :index, statuses: ['Won', 'Plan']

        expect(status).to eq(200)
        expect(body).to have_json_size(2)
        expect(JSON.parse(body)[0]['total_entries']).to eq(2)

      entries = [JSON.parse(body)[1][0]['id'], JSON.parse(body)[1][1]['id']]
      assert entries.include?(@deal1.id)
      assert entries.include?(@deal3.id)
      end
    end
  end

  describe "GET api/v1/deals/1" do
    it "shows designated person when given id is valid." do
      get :show, id: @deal1.id

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@deal1.id)
      expect(JSON.parse(body)['name']).to eq(@deal1.name)
    end
  end

  describe "POST api/v1/deals" do
    it "is able to create new record." do
      param = { name: 'new deal'}
      post :create, deal: param

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).not_to be_nil
      expect(JSON.parse(body)['name']).to eq('new deal')
    end

    it "is unable to create new record with invalid parameter" do
      param = { name: ''}
      post :create, deal: param

      expect(status).to eq(422)
      expect(body).to eq(JSON.generate({ name: [ "can't be blank" ] }))
    end
  end

  describe "PUT api/v1/update/1" do
    before(:each) do
      @update_deal = FactoryGirl.create(:deal)

      get :show, id: @update_deal.id
      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@update_deal.id)
    end

    after(:each) do
      @update_deal.destroy
    end

    it "is able to update existing record." do
      put :update, id: @update_deal.id, deal: {name: 'Updated Deal'}

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@update_deal.id)
      expect(JSON.parse(body)['name']).to eq('Updated Deal')
    end
    
    it "is unable to update existing record with invalid param." do
      put :update, id: @update_deal.id, deal: {name: ''}
      expect(status).to eq(422)
      expect(body).to be_json_eql(JSON.generate({ name: [ "can't be blank" ] }))
    end

  end

  describe "DELETE api/v1/destroy/1" do
    it "is able to delete existing record" do
      delete_deal = FactoryGirl.create(:deal)

      get :show, id: delete_deal.id
      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(delete_deal.id)

      delete :destroy, id: delete_deal.id
      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(delete_deal.id)

      get :show, id: delete_deal.id
      expect(status).to eq(404)
    end
  end

end
