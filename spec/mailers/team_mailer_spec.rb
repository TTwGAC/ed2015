require "spec_helper"

describe TeamMailer do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:player) { FactoryGirl.build(:player) }
  let(:team) { FactoryGirl.build(:team) }
  let(:mail) { TeamMailer.notify_member_joined(player, team) }
end
