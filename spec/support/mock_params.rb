# In place of full-blown Rails params to test some Rails-specific features
class MockParams < HashWithIndifferentAccess
  def initialize(hash)
    super(hash)
  end

  def permit!; end
end
