FactoryBot.define do
  factory :wiki do
    title "1234567"
    body "12345678909876543212"
    user
#    collaborator
    private false
  end
end
