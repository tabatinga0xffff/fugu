# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  properties :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  api_key_id :bigint           not null
#
# Indexes
#
#  index_events_on_api_key_id  (api_key_id)
#
# Foreign Keys
#
#  fk_rails_...  (api_key_id => api_keys.id)
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "has a valid factory" do
    assert build(:event)
  end

  context "validations" do
    subject { build(:event) }

    should validate_presence_of(:name)

    should belong_to(:api_key)

    should_not allow_value("Non JSON String").for(:properties)
    should_not allow_value("{invalid_json: \"12\"}").for(:properties)
  end
end
