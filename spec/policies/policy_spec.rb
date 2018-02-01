describe WikiPolicy do
  subject { described_class }

  permissions :update?, :edit? do
    it "grants access if user is standard" do
      expect(subject).to permit(User.new(role: 'standard'), Wiki.new())
    end

    it "grants access if user is admin" do
      expect(subject).to permit(User.new(role: 'admin'), Wiki.new())
    end

    it "grants access if user is premium" do
      expect(subject).to permit(User.new(role: 'premium'), Wiki.new())
    end
  end

  permissions :destroy? do
    it "denies access if user is standard" do
      expect(subject).not_to permit(User.new(role: 'standard'), Wiki.new())
    end

    it "grants access if user is admin" do
      expect(subject).to permit(User.new(role: 'admin'), Wiki.new())
    end

    it "denies access if user is premium" do
      expect(subject).not_to permit(User.new(role: 'premium'), Wiki.new())
    end

    it "grants access if user is standard and wiki user is current user" do
      expect(subject).to permit(user = User.new(role: 'standard'), Wiki.new(user: user))
    end

    it "grants access if user is premium and wiki user is current user" do
      expect(subject).to permit(user = User.new(role: 'premium'), Wiki.new(user: user))
    end
  end
end
