require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items), through: :invoice_items }
  end

  describe 'class methods' do
    context '.all_items' do
      it 'should return all items associated with single invoice' do
        invoice = create(:invoice)
        item_1 = create(:item)
        item_2 = create(:item)
        item_3 = create(:item)
        item_4 = create(:item)
        item_5 = create(:item)
        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id)
        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_4.id)
        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_5.id)

        expect(Invoice.all_items(invoice.id)).to eq([item_1, item_2, item_4, item_5])
      end
    end
  end
end
