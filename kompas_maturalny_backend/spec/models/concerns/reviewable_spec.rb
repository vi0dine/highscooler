shared_examples "reviewable" do
  it { is_expected.to have_many(:reviews) }
end